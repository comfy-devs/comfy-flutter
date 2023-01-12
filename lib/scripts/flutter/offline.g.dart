// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineManifest _$OfflineManifestFromJson(Map<String, dynamic> json) =>
    OfflineManifest(
      (json['shows'] as List<dynamic>)
          .map((e) => OfflineShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfflineManifestToJson(OfflineManifest instance) =>
    <String, dynamic>{
      'shows': instance.shows.map((e) => e.toJson()).toList(),
    };

OfflineShow _$OfflineShowFromJson(Map<String, dynamic> json) => OfflineShow(
      json['id'] as String,
      Show.fromJson(json['data'] as Map<String, dynamic>),
      (json['episodes'] as List<dynamic>)
          .map((e) => OfflineEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfflineShowToJson(OfflineShow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toJson(),
      'episodes': instance.episodes.map((e) => e.toJson()).toList(),
    };

OfflineEpisode _$OfflineEpisodeFromJson(Map<String, dynamic> json) =>
    OfflineEpisode(
      json['id'] as String,
      Episode.fromJson(json['data'] as Map<String, dynamic>),
      json['available'] as bool,
    );

Map<String, dynamic> _$OfflineEpisodeToJson(OfflineEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toJson(),
      'available': instance.available,
    };

OfflineTask _$OfflineTaskFromJson(Map<String, dynamic> json) => OfflineTask(
      json['id'] as String,
      Episode.fromJson(json['episode'] as Map<String, dynamic>),
      OfflineTaskState.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfflineTaskToJson(OfflineTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'episode': instance.episode.toJson(),
      'state': instance.state.toJson(),
    };

OfflineTaskState _$OfflineTaskStateFromJson(Map<String, dynamic> json) =>
    OfflineTaskState(
      json['id'] as String,
      json['status'] as int,
      json['progress'] as int,
    );

Map<String, dynamic> _$OfflineTaskStateToJson(OfflineTaskState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'progress': instance.progress,
    };
