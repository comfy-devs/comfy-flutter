// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      json['id'] as String,
      json['group'] as String?,
      json['season'] as int?,
      json['title'] as String,
      (json['altTitles'] as List<dynamic>).map((e) => e as String).toList(),
      json['synopsis'] as String?,
      json['episodes'] as int,
      json['favourites'] as int,
      json['type'] as int,
      json['format'] as int,
      json['status'] as int,
      json['genres'] as int,
      json['tags'] as int,
      json['rating'] as int,
      json['presets'] as int,
      json['location'] as int,
      json['timestamp'] as int?,
    );

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'season': instance.season,
      'title': instance.title,
      'altTitles': instance.altTitles,
      'synopsis': instance.synopsis,
      'episodes': instance.episodes,
      'favourites': instance.favourites,
      'type': instance.type,
      'format': instance.format,
      'status': instance.status,
      'genres': instance.genres,
      'tags': instance.tags,
      'rating': instance.rating,
      'presets': instance.presets,
      'location': instance.location,
      'timestamp': instance.timestamp,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['id'] as String,
      json['pos'] as int,
      json['show'] as String,
      json['title'] as String,
      json['views'] as int,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'show': instance.show,
      'title': instance.title,
      'views': instance.views,
    };

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
      json['id'] as String,
      json['pos'] as int,
      json['episode'] as String,
      json['type'] as int,
      json['length'] as int,
    );

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos,
      'episode': instance.episode,
      'type': instance.type,
      'length': instance.length,
    };
