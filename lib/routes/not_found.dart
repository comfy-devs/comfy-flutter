/* Base */
import 'package:flutter/material.dart';
import '../state/state.dart';

class NotFoundRoute extends StatelessWidget {
	final NyanAnimeState state;
	final Map<String, Function> actions;

	const NotFoundRoute({ Key? key, required this.state, required this.actions }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Column(
			children: const [
				Text("Not found!")
			]
		);
	}
}
