/* Base */
import 'dart:math';
import '../types/base.dart';
import '../types/api.dart';

class NyanAnimeState {
	String route = '/';
	Map<String, Anime> animes = {};
	Map<String, Episode> episodes = {};
	Map<String, Segment> segments = {};
	int random = Random().nextInt(1000000);
	FilterData filterData = FilterData("");

	NyanAnimeState();

	goToRoute(String _route) {
		route = _route;
	}

	selectAnime(String id) {
		route = '/animes/$id';
	}

	selectEpisode(String id) {
		route = '/episodes/$id';
	}

	setSearchTerm(String searchTerm) {
		filterData.searchTerm = searchTerm;
	}

}