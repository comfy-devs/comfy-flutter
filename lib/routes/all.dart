/* Base */
import 'package:flutter/material.dart';
import '../state/state.dart';
import '../types/api.dart';
/* Widgets */
import '../widgets/show_card.dart';

class AllRoute extends StatelessWidget {
  final ComfyState state;
  final Map<String, Function> actions;

  const AllRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Show> shows = state.shows.values
        .where((e) => e.title
            .toLowerCase()
            .contains(state.filterData.searchTerm.toLowerCase()))
        .toList();
    List<List<Show>> showChunks = [];
    for (int i = 0; i < shows.length; i += 2) {
      showChunks.add(
          shows.sublist(i, (i + 2 <= shows.length ? i + 2 : shows.length)));
    }

    return Wrap(children: [
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
          child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              children: [
                Text("Shows (${shows.length}):",
                    style: const TextStyle(fontSize: 23, color: Colors.white)),
                Container(
                    width: 300,
                    height: 30,
                    decoration: BoxDecoration(
                        color: const Color(0xff2f2f2f),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      onChanged: (text) => {actions["setSearchTerm"]!(text)},
                      decoration: const InputDecoration.collapsed(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Search...'),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: 320,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: showChunks.length,
                        itemBuilder: (BuildContext _context, int i) {
                          return Wrap(
                              children: showChunks[i]
                                  .map((el) => ShowCardWidget(
                                      state: state,
                                      item: el,
                                      small: true,
                                      actions: actions))
                                  .toList());
                        }))
              ]))
    ]);
  }
}
