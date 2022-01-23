/* Base */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'types/api.dart';
/* State */
import 'state/state.dart';
/* Widgets */
import 'widgets/header.dart';
import 'widgets/sub_header.dart';
/* Routes */
import 'routes/home.dart';
import 'routes/not_found.dart';
import 'routes/anime.dart';
import 'routes/episode.dart';
import 'routes/all.dart';
/* API */
import 'scripts/api/routes.dart';

void main() => runApp(const NyanAnimeApp());

class NyanAnimeApp extends StatefulWidget {
  	const NyanAnimeApp({Key? key}) : super(key: key);

    @override
  	NyanAnimeAppState createState() => NyanAnimeAppState();
}

class NyanAnimeAppState extends State<NyanAnimeApp> {
	NyanAnimeState state = NyanAnimeState();

    @override
    Widget build(BuildContext context) {
		// TODO: add seeking in VideoPlayerControls
		// TODO: add skipping openings and ending in VideoPlayer
		// TODO: add rest of the filters to All
		// TODO: add dubbed button to VideoPlayerControls
		// TODO: add quality button to VideoPlayerControls

		final Map<String, Function> actions = {
			'goToRoute': stateGoToRoute,
			'selectAnime': stateSelectAnime,
			'selectEpisode': stateSelectEpisode,
			'setSearchTerm': stateSetSearchTerm
		};

        return MaterialApp(
            title: 'Nyan Anime',
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    color: Color(0xff1b1b1b)
                )
            ),
            home: OrientationBuilder(builder: (_, orientation) {
				return WillPopScope(
					onWillPop: () => processPop(orientation),
					child: Scaffold(
						backgroundColor: const Color(0xff151515),
						appBar: PreferredSize(
							preferredSize: Size.fromHeight(MediaQuery.of(_).padding.top + 80),
							child: Visibility(
								visible: orientation == Orientation.portrait,
								child: AppBar(
									flexibleSpace: Column(
										mainAxisAlignment: MainAxisAlignment.start,
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											SizedBox(height: MediaQuery.of(_).padding.top + 10),
											HeaderWidget(actions: actions),
											const SizedBox(height: 10),
											SubHeaderWidget(actions: actions)
										]
									)
								)
							)
						),
						body: buildRoute(actions, orientation)
					)
				);
			})
        );
    }

	StatelessWidget buildRoute(Map<String, Function> actions,Orientation orientation) {
		StatelessWidget route;
		switch(state.route) {
			case '/':
				route = HomeRoute(state: state, actions: actions);
				break;

			case '/all':
				route = AllRoute(state: state, actions: actions);
				break;

			default:
				route = NotFoundRoute(state: state, actions: actions);
				break;
		}
		if(state.route.startsWith("/animes/")) { route = AnimeRoute(state: state, actions: actions); }
		if(state.route.startsWith("/episodes/")) { route = EpisodeRoute(state: state, orientation: orientation, actions: actions); }
		
		return route;
	}

	Future<bool> processPop(Orientation orientation) async {
		if(orientation == Orientation.landscape) {
			SystemChrome.setPreferredOrientations([
				DeviceOrientation.portraitUp,
				DeviceOrientation.portraitDown,
			]);
			return false;
		}
		if(state.route.startsWith("/episodes/")) {
			String id = state.route.substring("/episodes/".length);
			Episode? episode = state.episodes[id];
			if(episode == null) { 
				stateGoToRoute('/');
			} else {
				stateGoToRoute('/animes/${episode.anime}');
			}

			return false;
		}
		switch(state.route) {
			case '/':
				return true;
		}

		stateGoToRoute('/');
		return false;
	}

	@override
	void initState() {
		super.initState();
		setupApp();
	}

	@override
	void reassemble() {
		super.reassemble();
		setupApp();
	}

	void setupApp() async {
		List<Anime> animeList = await fetchAnimes();
		List<Episode> episodeList = await fetchEpisodes();
		List<Segment> segmentList = await fetchSegments();
		setState(() {
			for (var e in animeList) {
				state.animes[e.id] = e;
			}
			for (var e in episodeList) {
				state.episodes[e.id] = e;
			}
			for (var e in segmentList) {
				state.segments[e.id] = e;
			}
		});

		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
	}

	void stateGoToRoute(String route) { setState(() { state.goToRoute(route); }); }
	void stateSelectAnime(String id) { setState(() { state.selectAnime(id); }); }
	void stateSelectEpisode(String id) { setState(() { state.selectEpisode(id); }); }
	void stateSetSearchTerm(String searchTerm) { setState(() { state.setSearchTerm(searchTerm); }); }
}