/* Base */
import 'package:flutter/material.dart';
import '../state/state.dart';
import '../types/api.dart';
/* Widgets */
import '../widgets/anime_card.dart';

class AllRoute extends StatelessWidget {
	final NyanAnimeState state;
	final Map<String, Function> actions;

	const AllRoute({ Key? key, required this.state, required this.actions }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		// TODO: convert this using ListView.builder
		List<Anime> animes = state.animes.values.where((e) => e.title.toLowerCase().contains(state.filterData.searchTerm.toLowerCase())).toList();
		List<List<Anime>> animeChunks = [];
		for(int i = 0; i < animes.length; i += 2) {
			animeChunks.add(animes.sublist(i, (i + 2 <= animes.length ? i + 2 : animes.length)));
		}

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
							Text("Animes (${animes.length}):", style: const TextStyle(fontSize: 23, color: Colors.white)),
							Container(
								width: 300,
								height: 30,
								decoration: BoxDecoration(color: const Color(0xff2f2f2f), borderRadius: BorderRadius.circular(10)),
								alignment: Alignment.center,
								padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
								child: TextField(
									style: const TextStyle(color: Colors.white, fontSize: 12),
									onChanged: (text) => { actions["setSearchTerm"]!(text) },
									decoration: const InputDecoration.collapsed(
										hintStyle: TextStyle(color: Colors.grey),
										hintText: 'Search...'
									),
								)
							),
							Wrap(
								direction: Axis.vertical,
								children: animeChunks.map((e) => Wrap(children: e.map((el) => AnimeCardWidget(item: el, small: true, actions: actions)).toList() )).toList()
							)
						]
					)
				)
			]
		);
	}
}
