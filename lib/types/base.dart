/* Types */
class FilterData {
  String searchTerm;

  FilterData(this.searchTerm);
}

enum ShowType {
  TV,
  SPECIAL,
  OVA,
  MOVIE,
  ONA,
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
