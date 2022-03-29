/* Base */
import 'package:nyan_anime/types/base.dart';
import 'package:flutter/material.dart';
import '../types/api.dart';
import '../state/state.dart';
/* Widgets */
import '../widgets/home_topic.dart';

class HomeRoute extends StatelessWidget {
	final NyanAnimeState state;
	final Map<String, Function> actions;

	const HomeRoute({ Key? key, required this.state, required this.actions }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		List<Anime> animes = state.animes.values.toList();
		List<Anime> airingSet = animes.where((e) => e.status == AnimeStatus.AIRING.index).toList();
		List<Anime> soonSet = airingSet;
		soonSet.sort((a, b) => (b.timestamp ?? 0) - (a.timestamp ?? 0));
		List<Anime> latestSet = animes;
		latestSet.sort((a, b) => (b.timestamp ?? 0) - (a.timestamp ?? 0));
		List<Anime> randomSet = animes;
		randomSet = randomSet.isEmpty ? [] : [randomSet[state.random % randomSet.length]];

		return ListView(
			physics: const BouncingScrollPhysics(),
			children: [
				Container(
					alignment: Alignment.center,
					decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
					child: Wrap(
						children: [
							HomeTopicWidget(title: "Airing Animes", items: airingSet, actions: actions),
							HomeTopicWidget(title: "Airing Soon", items: soonSet, actions: actions, extra: 1),
							HomeTopicWidget(title: "Latest Episode", items: latestSet, actions: actions, extra: 0),
							HomeTopicWidget(title: "Random Anime", items: randomSet, actions: actions),
						]
					)
				)
			]
		);
	}
}
