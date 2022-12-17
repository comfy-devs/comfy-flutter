/* Base */
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nyan_anime/types/base_const.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../types/base.dart';
import '../types/api.dart';
import '../state/state.dart';
import '../scripts/nyan/constants.dart';
/* Widgets */
import '../widgets/episode_card.dart';

class AnimeRoute extends StatelessWidget {
  final NyanAnimeState state;
  final Map<String, Function> actions;

  const AnimeRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = state.route.substring("/animes/".length);
    Anime? anime = state.animes[id];
    if (anime == null) {
      return const Text("Not found...");
    }
    List<Episode> episodes = List<Episode>.from(
        state.episodes.values.where((e) => e.anime == anime.id));
    episodes.sort((b, a) => b.pos - a.pos);
    final title = anime.title.length < 18
        ? anime.title
        : "${anime.title.substring(0, 15)}...";
    final genres = AnimeGenres.where((e) => (anime.genres & e) == e)
        .map((e) => animeGenreToDisplayName(e))
        .join(", ");
    final tags = AnimeTags.where((e) => (anime.tags & e) == e)
        .map((e) => animeTagToDisplayName(e))
        .join(", ");
    final synopsis =
        anime.synopsis?.replaceAll("<br>", "\n") ?? "No synopsis...";
    final styleSheet = MarkdownStyleSheet(
        p: const TextStyle(color: Colors.white, fontSize: 14));

    return ListView(children: [
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
          child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              children: [
                Wrap(children: [
                  Text(title,
                      style: const TextStyle(
                          color: Color(0xffff3645), fontSize: 27))
                ]),
                SizedBox(
                    width: 200,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            imageUrl:
                                '${state.preferences.imageEndpoint}/${anime.id}/poster.webp',
                            httpHeaders: {
                              'Origin': state.preferences.imageEndpoint
                            },
                            errorWidget: (a, b, c) => const Text("a")))),
                Wrap(
                  spacing: 3,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: MarkdownBody(
                        data: synopsis,
                        styleSheet: styleSheet,
                      ),
                    ),
                    Container(
                        width: 120,
                        height: 1,
                        margin: const EdgeInsets.all(6),
                        color: const Color(0xff212121)),
                    Wrap(children: [
                      const Text("Type: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(animeTypeToDisplayName(AnimeType.values[anime.type]),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Status: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                          animeStatusToDisplayName(
                              AnimeStatus.values[anime.status]),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Genres: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(genres,
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Episodes: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(anime.episodes.toString(),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Container(
                        width: 80,
                        height: 1,
                        margin: const EdgeInsets.all(6),
                        color: const Color(0xff212121)),
                    Wrap(children: [
                      const Text("Favourites: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(anime.favourites.toString(),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Views: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(anime.favourites.toString(),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Container(
                        width: 80,
                        height: 1,
                        margin: const EdgeInsets.all(6),
                        color: const Color(0xff212121)),
                    Wrap(children: [
                      const Text("Tags: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(tags,
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ])
                  ],
                ),
                Wrap(
                    direction: Axis.vertical,
                    children: episodes
                        .map((e) => EpisodeCardWidget(
                            state: state, item: e, actions: actions))
                        .toList())
              ]))
    ]);
  }
}
