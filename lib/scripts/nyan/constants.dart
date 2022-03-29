/* Types */
import 'package:nyan_anime/scripts/nyan/util.dart';
import '../../types/base.dart';
import '../../types/base_const.dart' as constants;
import '../../types/api.dart';

String animeTypeToDisplayName(AnimeType type) {
    switch (type) {
        case AnimeType.TV:
            return "TV";

        case AnimeType.SPECIAL:
            return "Special";

        case AnimeType.OVA:
            return "OVA";

        case AnimeType.MOVIE:
            return "Movie";

        case AnimeType.ONA:
            return "ONA";
    }
}

String animeStatusToDisplayName(AnimeStatus status) {
    switch (status) {
        case AnimeStatus.AIRING:
            return "Airing";

        case AnimeStatus.FINISHED:
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

String animeTagToDisplayName(num tag) {
    switch (tag) {
        case constants.AnimeTag_SUBBED:
            return "Subbed";

        case constants.AnimeTag_HARD_SUBBED:
            return "Hard Subbed";

        case constants.AnimeTag_DUBBED:
            return "Dubbed";

		default:
			return "Unknown";
    }
}

String episodeLocationToURL(EpisodeLocation location) {
    switch(location) {
		case EpisodeLocation.AKAGI:
			return "https://akagi.nyananime.xyz";

		case EpisodeLocation.KAGA:
			return "https://kaga.nyananime.xyz";
	}
}

String? homeTopicExtra(Anime item, num? extra) {
	int? time = item.timestamp;
	if(extra == null || time == null) { return null; }
	switch(extra) {
		case 0: {
            String t = secondsToStringHuman((DateTime.now().millisecondsSinceEpoch / 1000).floor() - time);
            return '$t ago';
		}

		case 1: {
            String t = secondsToStringHuman(time + 604800 - (DateTime.now().millisecondsSinceEpoch / 1000).floor());
            String t2 = secondsToStringHuman((DateTime.now().millisecondsSinceEpoch / 1000).floor() - 604800 - time);
            return t == '??' ? '$t2 ago' : 'in $t';
		}

		default: {
			return '??';
		}
	}
}

