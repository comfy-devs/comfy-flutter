/* Base */
import '../../types/api.dart';
import 'api.dart';

Future<List<Anime>> fetchAnimes(state) async {
  final response = await get(APIGetRequest(state, '/animes/all/fetch'));
  if (response.status != 200) {
    return [];
  }

  return List<Anime>.from(
      (response.body as List<dynamic>).map((e) => Anime.fromJson(e)));
}

Future<List<Episode>> fetchEpisodes(state, id) async {
  final response =
      await get(APIGetRequest(state, '/animes/episodes/fetch?id=$id'));
  if (response.status != 200) {
    return [];
  }

  return List<Episode>.from(
      (response.body as List<dynamic>).map((e) => Episode.fromJson(e)));
}

Future<List<Segment>> fetchSegments(state, id) async {
  final response =
      await get(APIGetRequest(state, '/episodes/segments/fetch?id=$id'));
  if (response.status != 200) {
    return [];
  }

  return List<Segment>.from(
      (response.body as List<dynamic>).map((e) => Segment.fromJson(e)));
}
