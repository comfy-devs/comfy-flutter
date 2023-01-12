/* Base */
import 'dart:isolate';
import 'dart:math';
import 'package:comfy/scripts/flutter/offline.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../types/base.dart';
import '../types/api.dart';

class ComfyState {
  PackageInfo? packageInfo;
  List<String> offlineLocations = [];
  OfflineManifest offlineManifest = OfflineManifest([]);
  ReceivePort offlineDownloaderPort = ReceivePort();
  Map<String, OfflineTask> offlineTasks = {};
  SharedPreferences? sharedPreferences;

  Preferences preferences = Preferences();
  String route = '/';
  Map<String, Show> shows = {};
  Map<String, Episode> episodes = {};
  Map<String, Segment> segments = {};
  int random = Random().nextInt(1000000);
  FilterData filterData = FilterData("");

  goToRoute(String _route) {
    route = _route;
  }

  selectShow(String id) {
    route = '/shows/$id';
  }

  selectEpisode(String id) {
    route = '/episodes/$id';
  }

  setSearchTerm(String searchTerm) {
    filterData.searchTerm = searchTerm;
  }
}
