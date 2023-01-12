/* Base */
import 'package:comfy/types/base.dart';
import 'package:flutter/material.dart';
import '../types/api.dart';
import '../state/state.dart';
/* Widgets */
import '../widgets/home_topic.dart';

class HomeRoute extends StatelessWidget {
  final ComfyState state;
  final Map<String, Function> actions;

  const HomeRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Show> shows = state.shows.values.toList();
    List<Show> airingSet =
        shows.where((e) => e.status == ShowStatus.AIRING.index).toList();
    List<Show> soonSet = airingSet;
    soonSet.sort((a, b) => (b.timestamp ?? 0) - (a.timestamp ?? 0));
    List<Show> latestSet = shows;
    latestSet.sort((a, b) => (b.timestamp ?? 0) - (a.timestamp ?? 0));
    List<Show> randomSet = shows;
    randomSet =
        randomSet.isEmpty ? [] : [randomSet[state.random % randomSet.length]];

    return ListView(physics: const BouncingScrollPhysics(), children: [
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
          child: Wrap(children: [
            HomeTopicWidget(
                state: state,
                title: "Airing Shows",
                items: airingSet,
                actions: actions),
            HomeTopicWidget(
                state: state,
                title: "Airing Soon",
                items: soonSet,
                actions: actions,
                extra: 1),
            HomeTopicWidget(
                state: state,
                title: "Latest Episode",
                items: latestSet,
                actions: actions,
                extra: 0),
            HomeTopicWidget(
                state: state,
                title: "Random Shows",
                items: randomSet,
                actions: actions),
          ]))
    ]);
  }
}
