import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:comfy/state/state.dart';
import 'package:collection/collection.dart';
import '../../types/api.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../types/base.dart';
import '../comfy/constants.dart';
part 'offline.g.dart';

@JsonSerializable(explicitToJson: true)
class OfflineManifest {
  final List<OfflineShow> shows;

  OfflineManifest(this.shows);

  factory OfflineManifest.fromJson(Map<String, dynamic> json) =>
      _$OfflineManifestFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineManifestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OfflineShow {
  final String id;
  final Show data;
  final List<OfflineEpisode> episodes;

  OfflineShow(this.id, this.data, this.episodes);

  factory OfflineShow.fromJson(Map<String, dynamic> json) =>
      _$OfflineShowFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineShowToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OfflineEpisode {
  final String id;
  final Episode data;
  final bool available;

  OfflineEpisode(this.id, this.data, this.available);

  factory OfflineEpisode.fromJson(Map<String, dynamic> json) =>
      _$OfflineEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineEpisodeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OfflineTask {
  final String id;
  Episode episode;
  OfflineTaskState state;

  OfflineTask(this.id, this.episode, this.state);

  factory OfflineTask.fromJson(Map<String, dynamic> json) =>
      _$OfflineTaskFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineTaskToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OfflineTaskState {
  final String id;
  int status;
  int progress;

  OfflineTaskState(this.id, this.status, this.progress);

  factory OfflineTaskState.fromJson(Map<String, dynamic> json) =>
      _$OfflineTaskStateFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineTaskStateToJson(this);
}

Future<OfflineManifest> loadOfflineManifest(ComfyState state) async {
  try {
    String path = "${state.preferences.offlineModeLocation}/manifest.json";
    File f = File(path);
    return OfflineManifest.fromJson(jsonDecode(await f.readAsString()));
  } catch (e) {
    return OfflineManifest([]);
  }
}

Future<void> addEpisodeToOfflineManifest(ComfyState state, String id) async {
  Episode? episodeObj = state.episodes[id];
  if (episodeObj == null) {
    return;
  }
  Show? showObj = state.shows[episodeObj.show];
  if (showObj == null) {
    return;
  }

  OfflineShow? show =
      state.offlineManifest.shows.firstWhereOrNull((e) => e.id == showObj.id);
  if (show == null) {
    show = OfflineShow(showObj.id, showObj, []);
    state.offlineManifest.shows.add(show);
  }
  OfflineEpisode? episode =
      show.episodes.firstWhereOrNull((e) => e.id == episodeObj.id);
  if (episode == null) {
    episode = OfflineEpisode(episodeObj.id, episodeObj, true);
    show.episodes.add(episode);
  }

  String path = "${episodeObj.show}/${episodeObj.pos}";
  await Directory("${state.preferences.offlineModeLocation}/$path")
      .create(recursive: true);
  await FlutterDownloader.enqueue(
    url:
        '${episodeLocationToURL(state.preferences, EpisodeLocation.values[showObj.location])}/$path/episode_x264.mp4',
    headers: {},
    savedDir: "${state.preferences.offlineModeLocation}/$path",
    showNotification: true,
    openFileFromNotification: true,
  );

  saveOfflineManifest(state);
}

Future<void> saveOfflineManifest(ComfyState state) {
  String path = "${state.preferences.offlineModeLocation}/manifest.json";
  File f = File(path);
  return f.writeAsString(json.encode(state.offlineManifest));
}

@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send(OfflineTaskState(id, status.value, progress).toJson());
}

String getDeviceName(String? name) {
  if (name == null) {
    return "None";
  }
  if (name.startsWith("/data")) {
    return "Internal storage";
  } else {
    const l = "/storage/emulated/".length;
    final n = name.substring(l, l + 1);
    return "External storage ($n)";
  }
}
