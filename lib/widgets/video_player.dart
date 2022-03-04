/* Base */
import 'dart:async';
import 'package:NyanAnime/types/base_const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../types/base.dart';
import '../types/api.dart';
import '../scripts/nyan/webvtt.dart';
import '../scripts/nyan/constants.dart';
/* Widgets */
import 'video_player_controls.dart';
import 'video_player_caption.dart';

class VideoPlayerWidget extends StatefulWidget {
	final Episode item;
	final Anime parent;
	final List<Segment> segments;
	final Orientation orientation;
	final Map<String, Function> actions;

	const VideoPlayerWidget({ Key? key, required this.item, required this.parent, required this.segments, required this.orientation, required this.actions }) : super(key: key);

    @override
  	VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
	late VideoPlayerController controller;
	double controlsOpacity = 0;
	bool controlsVisible = false;
	Timer? controlsFadeAutoTimer;
	Timer? controlsFadeOutTimer;
	Timer? controlsSeekOutTimer;
	bool showSubtitles = true;
	num preset = EpisodePreset_HIGH;

    @override
    Widget build(BuildContext context) {
		final Map<String, Function> videoActions = {
			"play": processControlsPlay,
			"mute": processControlsMute,
			"subs": processControlsSubs,
			"seek": processControlsSeek
		};
		final w = widget.orientation == Orientation.portrait ? MediaQuery.of(context).size.width : (MediaQuery.of(context).size.height * (16/9));
		final h = widget.orientation == Orientation.portrait ? (MediaQuery.of(context).size.width / (16/9)) : MediaQuery.of(context).size.height;
		final btnSize = widget.orientation == Orientation.portrait ? 48.0 : 96.0;
		final btnIconSize = widget.orientation == Orientation.portrait ? 36.0 : 64.0;

        return Container(
			color: Colors.black,
			alignment: Alignment.center,
			child: SizedBox(
				width: w,
				child: Stack(
					children: [
						VideoPlayer(controller),
						Visibility(
							visible: showSubtitles,
							child: VideoPlayerCaptionWidget(controller: controller, orientation: widget.orientation),
						),
						AnimatedOpacity(
							opacity: controlsOpacity * 0.35,
							duration: const Duration(milliseconds: 300),
							child: Container(
								color: const Color(0xff000000)
							)
						),
						GestureDetector(
							onTap: () => {
								setState(() {
									controlsShow(controlsOpacity != 1);
								})
							}
						),
						AnimatedOpacity(
							opacity: controlsOpacity,
							duration: const Duration(milliseconds: 300),
							child: Visibility(
								visible: controlsVisible,
								child: Stack(
									children: [
										GestureDetector(
											onTap: () => {
												controlsShow(false)
											}
										),
										Wrap(
											alignment: WrapAlignment.center,
											crossAxisAlignment: WrapCrossAlignment.center,
											children: [
												SizedBox(
													width: ((w - btnSize) * 0.5),
													height: h,
													child: Stack(
														alignment: Alignment.center,
														children: [
															Image.asset("assets/icons/web/skip-back-96x96.png", width: btnIconSize * 0.75, height: btnIconSize * 0.75),
															InkWell(
																onTap: () => {
																	controlsSeekOutTimer = Timer(const Duration(milliseconds: 200), () => {
																		controlsShow(false)
																	})
																},
																onDoubleTap: () => {
																	controlsSeekOutTimer?.cancel(),
																	processControlsSeek(controller.value.position.inSeconds - 10)
																}
															)
														]
													)
												),
												SizedBox(
													width: btnSize,
													height: btnSize,
													child: Stack(
														alignment: Alignment.center,
														children: [
															Image.asset(controller.value.isPlaying ? "assets/icons/web/pause-96x96.png" : "assets/icons/web/play-96x96.png", width: btnIconSize, height: btnIconSize),
															InkWell(
																onTap: processControlsPlay
															)
														]
													)
												),
												SizedBox(
													width: ((w - btnSize) * 0.5),
													height: h,
													child: Stack(
														alignment: Alignment.center,
														children: [
															Image.asset("assets/icons/web/skip-forward-96x96.png", width: btnIconSize * 0.75, height: btnIconSize * 0.75),
															InkWell(
																onTap: () => {
																	controlsSeekOutTimer = Timer(const Duration(milliseconds: 200), () => {
																		controlsShow(false)
																	})
																},
																onDoubleTap: () => {
																	controlsSeekOutTimer?.cancel(),
																	processControlsSeek(controller.value.position.inSeconds + 10)
																}
															)
														]
													)
												)
											]
										),
										VideoPlayerControlsWidget(controller: controller, videoActions: videoActions, orientation: widget.orientation, w: w, showSubtitles: showSubtitles, segments: widget.segments, actions: widget.actions)
									]
								)
							)
						)
					]
				)
			)
		);
    }

	@override
	void initState() {
		super.initState();
		setupController();
	}

	@override
	void reassemble() {
		super.reassemble();
		setupController();
	}

	@override
	void dispose() {
		super.dispose();
		controller.dispose();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
		SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
	}

	void setupController() async {
		controller = VideoPlayerController.network(
			'${episodeLocationToURL(EpisodeLocation.values[widget.parent.location])}/${widget.item.anime}/${widget.item.pos}/${episodePresetToFile(preset)}',
			closedCaptionFile: loadSubtitles()
		);
		await controller.initialize();
		controller.play();
		setState(() {});
	}

	Future<WebVTTCaptionFile> loadSubtitles() async {
		final response = await http.get(Uri.parse('${episodeLocationToURL(EpisodeLocation.values[widget.parent.location])}/${widget.item.anime}/${widget.item.pos}/subs_en.vtt'));
		return WebVTTCaptionFile(parseSubtitles(response.body));
	}

	void processControlsPlay() {
		if(controller.value.isPlaying) {
			controller.pause();
		} else {
			controller.play();
		}
		setState(() {});
		controlsResetFadeAutoTimer();
	}

	void processControlsSeek(int seconds) {
		controller.seekTo(Duration(seconds: seconds));
		setState(() {});
		controlsResetFadeAutoTimer();
	}

	void processControlsMute() {
		if(controlsOpacity == 0) { return; }
		if(controller.value.volume == 0) {
			controller.setVolume(100);
		} else {
			controller.setVolume(0);
		}
		setState(() {});
		controlsResetFadeAutoTimer();
	}

	void processControlsSubs() {
		if(controlsOpacity == 0) { return; }
		setState(() {
		  	showSubtitles = !showSubtitles;
		});
		controlsResetFadeAutoTimer();
	}

	void controlsShow(bool visible) {
		setState(() {
			controlsOpacity = visible ? 1 : 0;
			if(visible) {
				if(controller.value.isPlaying) {
					controlsResetFadeAutoTimer();
				}
				controlsFadeOutTimer?.cancel();
				controlsVisible = true;
			} else {
				controlsResetFadeOutTimer();
				controlsFadeAutoTimer?.cancel();
			}
		});
	}

	void controlsResetFadeOutTimer() {
		controlsFadeOutTimer?.cancel();
		controlsFadeOutTimer = Timer(const Duration(milliseconds: 300), () => {
			setState(() { controlsVisible = false; })
		});
	}

	void controlsResetFadeAutoTimer() {
		controlsFadeAutoTimer?.cancel();
		controlsFadeAutoTimer = Timer(const Duration(seconds: 3), () => { controlsShow(false) });
	}

}
