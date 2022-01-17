/* Base */
import 'package:flutter/material.dart';
import '../types/api.dart';
import '../scripts/nyan/constants.dart';
/* Widgets */
import 'anime_card.dart';

class HomeTopicWidget extends StatelessWidget {
	final String title;
	final int? extra;
	final List<Anime> items;
	final Map<String, Function> actions;

	const HomeTopicWidget({ Key? key, required this.title, required this.items, required this.actions, this.extra }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Wrap(
			children: [
				Container(
					padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
					child: Text(title, style: const TextStyle( color: Color(0xffff3645), fontSize: 24 )),
				),
				Container(
					height: 300,
					padding: const EdgeInsets.all(10),
					child: ListView.builder(
						physics: const BouncingScrollPhysics(),
						scrollDirection: Axis.horizontal,
						itemCount: items.length,
						itemBuilder: (BuildContext _context, int i) {
							final item = items.elementAt(i);
							return AnimeCardWidget(item: item, extra: homeTopicExtra(item, extra), actions: actions);
						}
					)
				)
			]
		);
	}
}
