/* Types */
class FilterData {
	String searchTerm;

	FilterData(this.searchTerm);
}

enum AnimeType {
    TV,
    SPECIAL,
    OVA,
    MOVIE,
    ONA,
}

enum AnimeStatus {
    AIRING,
    FINISHED,
}

enum AnimeRating {
    PG,
    R,
}

enum EpisodeLocation {
    AKAGI, KAGA
}

enum SegmentType {
    OP, EPISODE, ED
}
