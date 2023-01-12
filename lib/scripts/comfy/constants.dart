/* Types */
import 'package:comfy/scripts/comfy/util.dart';
import '../../types/base.dart';
import '../../types/base_const.dart' as constants;
import '../../types/api.dart';

String showTypeToDisplayName(ShowType type) {
  switch (type) {
    case ShowType.TV:
      return "TV";

    case ShowType.SPECIAL:
      return "Special";

    case ShowType.OVA:
      return "OVA";

    case ShowType.MOVIE:
      return "Movie";

    case ShowType.ONA:
      return "ONA";
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

String showGenreToDisplayName(num genre) {
  switch (genre) {
    case constants.ShowGenre_ACTION:
      return "Action";

    case constants.ShowGenre_ADVENTURE:
      return "Adventure";

    case constants.ShowGenre_COMEDY:
      return "Comedy";

    case constants.ShowGenre_DRAMA:
      return "Drama";

    case constants.ShowGenre_ECCHI:
      return "Ecchi";

    case constants.ShowGenre_FANTASY:
      return "Fantasy";

    case constants.ShowGenre_HORROR:
      return "Horror";

    case constants.ShowGenre_MAHOU_SHOUJO:
      return "Mahou Shoujo";

    case constants.ShowGenre_MECHA:
      return "Mecha";

    case constants.ShowGenre_MUSIC:
      return "Music";

    case constants.ShowGenre_MYSTERY:
      return "Mystery";

    case constants.ShowGenre_PSYCHOLOGICAL:
      return "Psychological";

    case constants.ShowGenre_ROMANCE:
      return "Romance";

    case constants.ShowGenre_SCIFI:
      return "Sci-Fi";

    case constants.ShowGenre_SLICE_OF_LIFE:
      return "Slice of Life";

    case constants.ShowGenre_SPORTS:
      return "Sports";

    case constants.ShowGenre_SUPERNATURAL:
      return "Super Natural";

    case constants.ShowGenre_THRILLER:
      return "Thriller";

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
