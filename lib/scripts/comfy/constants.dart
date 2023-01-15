/* Types */
import 'package:comfy/scripts/comfy/util.dart';
import '../../types/base.dart';
import '../../types/base_const.dart' as constants;
import '../../types/api.dart';

String showTypeToDisplayName(ShowType type) {
  switch (type) {
    case ShowType.ANIME:
      return "Anime";
    case ShowType.TV:
      return "TV";
  }
}

String animeFormatToDisplayName(AnimeFormat format) {
  switch (format) {
    case AnimeFormat.TV:
      return "TV";
    case AnimeFormat.SPECIAL:
      return "Special";
    case AnimeFormat.OVA:
      return "OVA";
    case AnimeFormat.MOVIE:
      return "Movie";
    case AnimeFormat.ONA:
      return "ONA";
  }
}

String tvFormatToDisplayName(TVFormat format) {
  switch (format) {
    case TVFormat.TV:
      return "TV";
    case TVFormat.SPECIAL:
      return "Special";
    case TVFormat.MOVIE:
      return "Movie";
  }
}

String showStatusToDisplayName(ShowStatus status) {
  switch (status) {
    case ShowStatus.AIRING:
      return "Airing";
    case ShowStatus.FINISHED:
      return "Finished";
  }
}

String animeGenreToDisplayName(num genre) {
  switch (genre) {
    case constants.AnimeGenre_ACTION:
      return "Action";
    case constants.AnimeGenre_ADVENTURE:
      return "Adventure";
    case constants.AnimeGenre_COMEDY:
      return "Comedy";
    case constants.AnimeGenre_DRAMA:
      return "Drama";
    case constants.AnimeGenre_ECCHI:
      return "Ecchi";
    case constants.AnimeGenre_FANTASY:
      return "Fantasy";
    case constants.AnimeGenre_HORROR:
      return "Horror";
    case constants.AnimeGenre_MAHOU_SHOUJO:
      return "Mahou Shoujo";
    case constants.AnimeGenre_MECHA:
      return "Mecha";
    case constants.AnimeGenre_MUSIC:
      return "Music";
    case constants.AnimeGenre_MYSTERY:
      return "Mystery";
    case constants.AnimeGenre_PSYCHOLOGICAL:
      return "Psychological";
    case constants.AnimeGenre_ROMANCE:
      return "Romance";
    case constants.AnimeGenre_SCIFI:
      return "Sci-Fi";
    case constants.AnimeGenre_SLICE_OF_LIFE:
      return "Slice of Life";
    case constants.AnimeGenre_SPORTS:
      return "Sports";
    case constants.AnimeGenre_SUPERNATURAL:
      return "Super Natural";
    case constants.AnimeGenre_THRILLER:
      return "Thriller";
    default:
      return "Unknown";
  }
}

String tvGenreToDisplayName(num genre) {
  switch (genre) {
    case constants.TVGenre_ACTION:
      return "Action";
    case constants.TVGenre_ADVENTURE:
      return "Adventure";
    case constants.TVGenre_ANIMATION:
      return "Animation";
    case constants.TVGenre_AWARDS_SHOW:
      return "Awards Show";
    case constants.TVGenre_CHILDREN:
      return "Children";
    case constants.TVGenre_COMEDY:
      return "Comedy";
    case constants.TVGenre_CRIME:
      return "Crime";
    case constants.TVGenre_DOCUMENTARY:
      return "Documentary";
    case constants.TVGenre_DRAMA:
      return "Drama";
    case constants.TVGenre_FAMILY:
      return "Family";
    case constants.TVGenre_FANTASY:
      return "Fantasy";
    case constants.TVGenre_FOOD:
      return "Food";
    case constants.TVGenre_GAME_SHOW:
      return "Game Show";
    case constants.TVGenre_HISTORY:
      return "History";
    case constants.TVGenre_HOME_GARDEN:
      return "Home & Garden";
    case constants.TVGenre_HORROR:
      return "Horror";
    case constants.TVGenre_INDIE:
      return "Indie";
    case constants.TVGenre_MARTIAL_ARTS:
      return "Martial Arts";
    case constants.TVGenre_MINI_SERIES:
      return "Mini Series";
    case constants.TVGenre_MUSICAL:
      return "Musical";
    case constants.TVGenre_MYSTERY:
      return "Mystery";
    case constants.TVGenre_NEWS:
      return "News";
    case constants.TVGenre_PODCAST:
      return "Podcast";
    case constants.TVGenre_REALITY:
      return "Reality";
    case constants.TVGenre_ROMANCE:
      return "Romance";
    case constants.TVGenre_SCIENCE_FICTION:
      return "Science Fiction";
    case constants.TVGenre_SOAP:
      return "Soap";
    case constants.TVGenre_SPORT:
      return "Sport";
    case constants.TVGenre_SUSPENSE:
      return "Suspense";
    case constants.TVGenre_TALK_SHOW:
      return "Talk Show";
    case constants.TVGenre_THRILLER:
      return "Thriller";
    case constants.TVGenre_TRAVEL:
      return "Travel";
    case constants.TVGenre_WAR:
      return "War";
    case constants.TVGenre_WESTERN:
      return "Western";
    default:
      return "Unknown";
  }
}

String showTagToDisplayName(num tag) {
  switch (tag) {
    case constants.ShowTag_SUBBED:
      return "Subbed";
    case constants.ShowTag_HARD_SUBBED:
      return "Hard Subbed";
    case constants.ShowTag_DUBBED:
      return "Dubbed";
    default:
      return "Unknown";
  }
}

String episodeLocationToURL(Preferences preferences, EpisodeLocation location) {
  switch (location) {
    case EpisodeLocation.VAPOREON:
      return preferences.vaporeonEndpoint;
    case EpisodeLocation.JOLTEON:
      return "https://jolteon.comfy.lamkas.dev";
    case EpisodeLocation.FLAREON:
      return "https://flareon.comfy.lamkas.dev";
  }
}

String? homeTopicExtra(Show item, num? extra) {
  int? time = item.timestamp;
  if (extra == null || time == null) {
    return null;
  }
  switch (extra) {
    case 0:
      {
        String t = secondsToStringHuman(
            (DateTime.now().millisecondsSinceEpoch / 1000).floor() - time, 3);
        return '$t ago';
      }

    case 1:
      {
        String t = secondsToStringHuman(
            time +
                604800 -
                (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
            3);
        String t2 = secondsToStringHuman(
            (DateTime.now().millisecondsSinceEpoch / 1000).floor() -
                604800 -
                time,
            3);
        return t == '??' ? '$t2 ago' : 'in $t';
      }

    default:
      {
        return '??';
      }
  }
}
