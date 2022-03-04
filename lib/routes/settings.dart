/* Base */
import 'package:flutter/material.dart';
import '../state/state.dart';

class SettingsRoute extends StatelessWidget {
	final NyanAnimeState state;
	final Map<String, Function> actions;

	const SettingsRoute({ Key? key, required this.state, required this.actions }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ListView(
			children: [
				Container(
					alignment: Alignment.center,
					padding: const EdgeInsets.all(20),
					decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
					child: Wrap(
						direction: Axis.vertical,
						crossAxisAlignment: WrapCrossAlignment.center,
						spacing: 15,
						children: [
							const Text("Settings", style: TextStyle(fontSize: 23, color: Colors.white)),
							SizedBox(
								height: 35,
								width: 250,
								child: TextButton(
									onPressed: () {
										state.preferences.skipToPlayer = !state.preferences.skipToPlayer;
										actions["setPreferences"]!(state.preferences);
									},
									child: Text("Skip to video player: ${state.preferences.skipToPlayer ? 'Yes' : 'No'}", style: const TextStyle( color: Colors.white, fontSize: 13 )),
									style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2f2f2f)))
								)
							)
						]
					)
				)
			]
		);
	}
}
