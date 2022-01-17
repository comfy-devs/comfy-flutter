/* Base */
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../types/api.dart';

class AnimeCardWidget extends StatelessWidget {
	final Anime item;
	final bool small;
	final String? extra;
	final Map<String, Function> actions;

	const AnimeCardWidget({ Key? key, required this.item, required this.actions, this.small = false, this.extra }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final w = (MediaQuery.of(context).size.width / 2) - (small ? 45 : 18);
		final h = small ? 240.0 : 300.0;
		final hO = small ? 30.0 : 40.0;
		final fs0 = small ? 10.0 : 12.0;
		final title = item.title.length < 18 ? item.title : "${item.title.substring(0, 15)}...";

		return InkWell(
			onTap: () { actions["selectAnime"]!(item.id); },
			child: Container(
				width: w,
				margin: const EdgeInsets.all(4),
				decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff212121)),
				clipBehavior: Clip.hardEdge,
				child: Stack(
					children: [
						SizedBox(
							height: h,
							child: CachedNetworkImage(
								imageUrl: 'https://image.nyananime.xyz/${item.id}/poster.webp',
								httpHeaders: const { 'Origin': 'https://nyananime.xyz' }, fit: BoxFit.cover,
								errorWidget: (a, b, c) => const Text("a")
							)
						),
						Positioned(
							bottom: -1,
							left: 0,
							height: hO,
							width: w,
							child: Container(
								alignment: Alignment.center,
								color: const Color(0xc9424242),
 								child: Wrap(
									alignment: WrapAlignment.center,
									crossAxisAlignment: WrapCrossAlignment.center,
									spacing: 5,
									children: [
										Text(title, style: TextStyle(color: Colors.white, fontSize: fs0)),
										Text(item.favourites.toString(), style: TextStyle(color: const Color(0xffff3645), fontSize: fs0)),
										Image.asset('assets/icons/web/star-48x48.png', width: fs0, height: fs0)
									]
								)
							)
						),
						Visibility(
							visible: extra != null,
							child: Positioned(
								bottom: 45,
								right: 15,
								height: 30,
								child: Container(
									alignment: Alignment.center,
									padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
									decoration: BoxDecoration(color: const Color(0xc9424242), borderRadius: BorderRadius.circular(10)),
									child: Text(extra ?? "", style: TextStyle(color: const Color(0xff23ff83), fontSize: fs0))
								)
							)
						)
					]
				)
			) 
		);
	}
}
