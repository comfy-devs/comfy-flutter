/* Base */
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:comfy/types/base_const.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../types/base.dart';
import '../types/api.dart';
import '../state/state.dart';
import '../scripts/comfy/constants.dart';
/* Widgets */
import '../widgets/episode_card.dart';

class ShowRoute extends StatelessWidget {
  final ComfyState state;
  final Map<String, Function> actions;

  const ShowRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = state.route.substring("/shows/".length);
    Show? show = state.shows[id];
    if (show == null) {
      return const Text("Not found...");
    }
    List<Episode> episodes = List<Episode>.from(
        state.episodes.values.where((e) => e.show == show.id));
    episodes.sort((b, a) => b.pos - a.pos);
    final title = show.title.length < 18
        ? show.title
        : "${show.title.substring(0, 15)}...";
    final genres = ShowGenres.where((e) => (show.genres & e) == e)
        .map((e) => showGenreToDisplayName(e))
        .join(", ");
    final tags = ShowTags.where((e) => (show.tags & e) == e)
        .map((e) => showTagToDisplayName(e))
        .join(", ");
    final synopsis =
        show.synopsis?.replaceAll("<br>", "\n") ?? "No synopsis...";
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
                                '${state.preferences.imageEndpoint}/${show.id}/poster.webp',
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
                      Text(showTypeToDisplayName(ShowType.values[show.type]),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Status: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                          showStatusToDisplayName(
                              ShowStatus.values[show.status]),
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
                      Text(show.episodes.toString(),
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
                      Text(show.favourites.toString(),
                          style: const TextStyle(
                              color: Color(0xffff3645), fontSize: 12))
                    ]),
                    Wrap(children: [
                      const Text("Views: ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(show.favourites.toString(),
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
