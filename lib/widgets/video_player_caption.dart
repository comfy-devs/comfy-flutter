/* Base */
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCaptionWidget extends StatefulWidget {
	final VideoPlayerController controller;
	final Orientation orientation;

	const VideoPlayerCaptionWidget({ Key? key, required this.controller, required this.orientation }) : super(key: key);

    @override
  	VideoPlayerCaptionWidgetState createState() => VideoPlayerCaptionWidgetState();
}

class VideoPlayerCaptionWidgetState extends State<VideoPlayerCaptionWidget> {
	int lastCaption = -1;

    @override
    Widget build(BuildContext context) {
		double captionSize = widget.orientation == Orientation.portrait ? 15 : 32;
		String caption = widget.controller.value.caption.text;
		FontStyle captionStyle = caption.contains('/NYAN_I/') ? FontStyle.italic : FontStyle.normal;
		FontWeight captionWeight = caption.contains('/NYAN_B/') ? FontWeight.bold : FontWeight.normal;
		TextDecoration captionDecoration = caption.contains('/NYAN_U/') ? TextDecoration.underline : TextDecoration.none;
		caption = caption.replaceAll('/NYAN_N/', '\n');
		caption = caption.replaceAll('/NYAN_I/', '');
		caption = caption.replaceAll('/NYAN_B/', '');
		caption = caption.replaceAll('/NYAN_U/', '');

        return Stack(
			children: [
				ClosedCaption(
					text: caption,
					textStyle: TextStyle(
						fontSize: captionSize,
						fontStyle: captionStyle,
						fontWeight: captionWeight,
						decoration: captionDecoration,
						foreground: Paint()
							..style = PaintingStyle.stroke
							..strokeWidth = 4
							..color = Colors.black
					)
				),
				ClosedCaption(
					text: caption,
					textStyle: TextStyle(
						fontSize: captionSize,
						fontStyle: captionStyle,
						fontWeight: captionWeight,
						decoration: captionDecoration,
						color: Colors.white
					)
				)
			]
		);
    }

	@override
	void initState() {
		super.initState();
		widget.controller.addListener(videoCaptionCallback);
	}

	@override
	void reassemble() {
		super.reassemble();
		widget.controller.addListener(videoCaptionCallback);
	}

	@override
	void dispose() {
		widget.controller.removeListener(videoCaptionCallback);
		super.dispose();
	}

	void videoCaptionCallback() {
		if(widget.controller.value.caption.number != lastCaption) {
			lastCaption = widget.controller.value.caption.number;
			setState(() { });
		}
	}

}
