/* Base */
import 'package:flutter/material.dart';
import 'package:nyan_anime/scripts/flutter/offline.dart';
import 'package:nyan_anime/widgets/settings_option_button.dart';
import '../types/api.dart';
import '../state/state.dart';
/* Widgets */
import '../widgets/video_player.dart';

class EpisodeRoute extends StatelessWidget {
  final NyanAnimeState state;
  final Orientation orientation;
  final Map<String, Function> actions;

  const EpisodeRoute(
      {Key? key,
      required this.state,
      required this.orientation,
      required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = state.route.substring("/episodes/".length);
    Episode? episode = state.episodes[id];
    if (episode == null) {
      return const Text("Not found...");
    }
    Anime? anime = state.animes[episode.anime];
    if (anime == null) {
      return const Text("Not found...");
    }
    final pH = orientation == Orientation.portrait
        ? (MediaQuery.of(context).size.width * (9 / 16))
        : MediaQuery.of(context).size.height;
    final segments =
        state.segments.values.where((e) => e.episode == episode.id).toList();
    segments.sort((b, a) => b.pos - a.pos);

    return ListView(physics: const BouncingScrollPhysics(), children: [
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
          child: Wrap(children: [
            Visibility(
                visible: orientation == Orientation.portrait,
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      children: [
                        Text("Episode ${(episode.pos + 1)} - ",
                            style: const TextStyle(color: Colors.grey)),
                        Text(episode.title,
                            style: const TextStyle(color: Colors.red))
                      ],
                    ))),
            SizedBox(
                height: pH,
                child: VideoPlayerWidget(
                    state: state,
                    item: episode,
                    parent: anime,
                    segments: segments,
                    orientation: orientation,
                    actions: actions)),
            Visibility(
                visible: orientation == Orientation.portrait,
                child: Wrap(children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        children: [
                          const Text("Anime: ",
                              style: TextStyle(color: Colors.grey)),
                          Text(anime.title,
                              style: const TextStyle(color: Colors.red))
                        ],
                      )),
                  SettingsOptionButton(
                    text: "Offline",
                    onClick: () => {addEpisodeToOfflineManifest(state, id)},
                  )
                ]))
          ]))
    ]);
  }
}
