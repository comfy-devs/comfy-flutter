/* Base Types */
import 'package:comfy/state/state.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api.g.dart';

class APIGetRequest {
  final ComfyState state;
  final String path;

  APIGetRequest(this.state, this.path);
}

class APIPostRequest {
  final ComfyState state;
  final String path;
  final Object body;

  APIPostRequest(this.state, this.path, this.body);
}

class APIResponse {
  final int status;
  final Object body;

  APIResponse(this.status, this.body);
}

/* Types */
class Preferences {
  bool skipToPlayer = false;
  String apiEndpoint = "https://api.comfy.lamkas.dev";
  String imageEndpoint = "https://image.comfy.lamkas.dev";
  String vaporeonEndpoint = "https://vaporeon.comfy.lamkas.dev";
  bool dev = false;
  String? offlineModeLocation;
}

@JsonSerializable(explicitToJson: true)
class Show {
  final String id;
  final String? group;
  final int? season;
  final String title;
  final String? synopsis;
  final int episodes;
  final int favourites;
  final int type;
  final int status;
  final int genres;
  final int tags;
  final int rating;
  final int presets;
  final int location;
  final int? timestamp;

  Show(
      this.id,
      this.group,
      this.season,
      this.title,
      this.synopsis,
      this.episodes,
      this.favourites,
      this.type,
      this.status,
      this.genres,
      this.tags,
      this.rating,
      this.presets,
      this.location,
      this.timestamp);

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
  Map<String, dynamic> toJson() => _$ShowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Episode {
  final String id;
  final int pos;
  final String show;
  final String title;
  final int views;

  Episode(this.id, this.pos, this.show, this.title, this.views);

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Segment {
  final String id;
  final int pos;
  final String episode;
  final int type;
  final int length;

  Segment(this.id, this.pos, this.episode, this.type, this.length);

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);
  Map<String, dynamic> toJson() => _$SegmentToJson(this);
}
