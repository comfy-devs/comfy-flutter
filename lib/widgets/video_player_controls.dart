/* Base */
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../types/base.dart';
import '../types/api.dart';
import '../scripts/nyan/constants.dart';
import '../scripts/nyan/util.dart';

class VideoPlayerControlsWidget extends StatefulWidget {
	final VideoPlayerController controller;
	final Map<String, Function> videoActions;
	final List<Segment> segments;
	final Orientation orientation;
	final double w;
	final bool showSubtitles;
	final Map<String, Function> actions;

	const VideoPlayerControlsWidget({ Key? key, required this.controller, required this.videoActions, required this.segments, required this.orientation, required this.w, required this.showSubtitles, required this.actions }) : super(key: key);

    @override
  	VideoPlayerControlsWidgetState createState() => VideoPlayerControlsWidgetState();
}

class VideoPlayerControlsWidgetState extends State<VideoPlayerControlsWidget> {
	int lastPosition = -1;

    @override
    Widget build(BuildContext context) {
		final btnSize = widget.orientation == Orientation.portrait ? 36.0 : 50.0;
		final timelineHeight = widget.orientation == Orientation.portrait ? 10.0 : 15.0;

        return Container(
			alignment: Alignment.bottomCenter,
			child: Opacity(
				opacity: 0.9,
				child: Stack(
					alignment: Alignment.bottomCenter,
					children: [
						Container(
							height: btnSize + timelineHeight + 5,
							padding: const EdgeInsets.all(5),
							decoration: const BoxDecoration(color: Color(0xff444444), borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
							child: Wrap(
								children: [
									SizedBox(
										width: btnSize,
										height: btnSize,
										child: Stack(
											alignment: Alignment.center,
											children: [
												Image.asset(widget.controller.value.volume == 0 ? "assets/icons/web/volume-mute-48x48.png" : "assets/icons/web/volume-48x48.png", width: 24, height: 24),
												InkWell(
													onTap: () => { widget.videoActions["mute"]!() },
												)
											]
										)
									),
									Container(
										width: btnSize,
										height: btnSize,
										foregroundDecoration: widget.showSubtitles ? null : const BoxDecoration(
											color: Colors.grey,
											backgroundBlendMode: BlendMode.saturation
										),
										child: Stack(
											alignment: Alignment.center,
											children: [
												Image.asset("assets/icons/web/subs-48x48.png", width: 24, height: 24),
												InkWell(
													onTap: () => { widget.videoActions["subs"]!() },
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
												Image.asset("assets/icons/web/fullscreen-48x48.png", width: 24, height: 24),
												InkWell(
													onTap: () => {
														if(widget.orientation == Orientation.portrait) {
															SystemChrome.setPreferredOrientations([
																DeviceOrientation.landscapeRight,
																DeviceOrientation.landscapeLeft,
															]),
															SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
														} else {
															SystemChrome.setPreferredOrientations([
																DeviceOrientation.portraitDown,
																DeviceOrientation.portraitUp,
															]),
															SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values)
														}
													}
												)
											]
										)
									)
								]
							)
						),
						Positioned(
							child: Container(
								height: timelineHeight,
								color: const Color(0xff555555)
							)
						),
						Positioned(
							left: 0,
							child: Container(
								height: timelineHeight,
								width: widget.controller.value.duration.inSeconds == 0 ? 0 : widget.w * (widget.controller.value.position.inSeconds / widget.controller.value.duration.inSeconds),
								color: const Color(0xffff3645)
							)
						),
						Positioned(
							left: 0,
							child: Opacity(
								opacity: 0.5,
								child: Wrap(
									children: widget.segments.map((e) =>
										Container(
											height: timelineHeight,
											width: widget.controller.value.duration.inSeconds == 0 ? 0 : widget.w * (e.length / widget.controller.value.duration.inSeconds),
											color: segmentTypeToColor(SegmentType.values[e.type]),
											alignment: Alignment.center,
											child: Text(segmentTypeToDisplayName(SegmentType.values[e.type]), style: const TextStyle(color: Colors.white, fontSize: 7))
										)
									).toList()
								)
							)
						),
						Positioned(
							left: 5,
							bottom: timelineHeight + 10,
							child: Container(
								padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
								decoration: BoxDecoration(color: const Color(0xff555555), borderRadius: BorderRadius.circular(10)),
								child: Text("${secondsToString(widget.controller.value.position.inSeconds)} / ${secondsToString(widget.controller.value.duration.inSeconds)}", style: const TextStyle(color: Colors.white, fontSize: 12))
							)
						)
					]
				)
			),
		);
    }

	@override
	void initState() {
		super.initState();
		widget.controller.addListener(videoControlsCallback);
	}

	@override
	void reassemble() {
		super.reassemble();
		widget.controller.addListener(videoControlsCallback);
	}

	@override
	void dispose() {
		widget.controller.removeListener(videoControlsCallback);
		super.dispose();
	}

	void videoControlsCallback() {
		if(widget.controller.value.position.inSeconds != lastPosition) {
			lastPosition = widget.controller.value.position.inSeconds;
			setState(() { });
		}
	}

}