/* Types */
class FilterData {
  String searchTerm;

  FilterData(this.searchTerm);
}

enum ShowType { ANIME, TV }

enum AnimeFormat {
  TV,
  SPECIAL,
  OVA,
  MOVIE,
  ONA,
}

enum TVFormat {
  TV,
  SPECIAL,
  MOVIE,
}

enum ShowStatus {
  AIRING,
  FINISHED,
}

enum ShowRating {
  PG,
  R,
}

enum EpisodeLocation { VAPOREON, JOLTEON, FLAREON }

enum SegmentType { OP, EPISODE, ED }
