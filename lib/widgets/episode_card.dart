/* Base */
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../types/api.dart';

class EpisodeCardWidget extends StatelessWidget {
	final Episode item;
	final Map<String, Function> actions;

	const EpisodeCardWidget({ Key? key, required this.item, required this.actions }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final w = MediaQuery.of(context).size.width - 60;
		final title = item.title.length < 36 ? item.title : "${item.title.substring(0, 33)}...";

		return InkWell(
			onTap: () { actions["selectEpisode"]!(item.id); },
			child: Container(
				width: w,
				margin: const EdgeInsets.all(4),
				decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff212121)),
				clipBehavior: Clip.hardEdge,
				child: Stack(
					children: [
						ClipRRect(
							child: CachedNetworkImage(
								imageUrl: 'https://image.nyananime.xyz/${item.anime}/${item.pos}/thumbnail.webp',
								httpHeaders: const { 'Origin': 'https://nyananime.xyz' }, fit: BoxFit.fill,
								errorWidget: (a, b, c) => Container()
							)
						),
						Positioned.fill(
							top: null,
							child: Container(
								height: 30,
								alignment: Alignment.center,
								color: const Color(0xc9424242),
								child: Wrap(
									alignment: WrapAlignment.center,
									crossAxisAlignment: WrapCrossAlignment.center,
									spacing: 5,
									children: [
										Text(title, style: const TextStyle(color: Colors.white, fontSize: 11)),
										Text(item.views.toString(), style: const TextStyle(color: Color(0xffff3645), fontSize: 11)),
										Image.asset('assets/icons/web/eye-48x48.png', width: 12, height: 12)
									]
								)
							)
						)
					]
				)
			)
		);
	}
}
