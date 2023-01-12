/* Base */
import 'dart:io';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:comfy/routes/offline.dart';
import 'package:comfy/routes/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:comfy/scripts/flutter/development.dart';
import 'package:comfy/scripts/flutter/offline.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'types/api.dart';
/* State */
import 'state/state.dart';
/* Widgets */
import 'widgets/header.dart';
import 'widgets/sub_header.dart';
/* Routes */
import 'routes/home.dart';
import 'routes/not_found.dart';
import 'routes/show.dart';
import 'routes/episode.dart';
import 'routes/all.dart';
/* API */
import 'scripts/api/routes.dart';

void main() => runApp(const ComfyApp());

class ComfyApp extends StatefulWidget {
  const ComfyApp({Key? key}) : super(key: key);

  @override
  ComfyAppState createState() => ComfyAppState();
}

class ComfyAppState extends State<ComfyApp> {
  ComfyState state = ComfyState();
  static const MethodChannel _channel = MethodChannel('comfy');

  @override
  Widget build(BuildContext context) {
    // TODO: add seeking in VideoPlayerControls
    // TODO: add skipping openings and ending in VideoPlayer
    // TODO: add rest of the filters to All
    // TODO: add dubbed button to VideoPlayerControls
    // TODO: add quality button to VideoPlayerControls

    final Map<String, Function> actions = {
      'goToRoute': stateGoToRoute,
      'selectShow': stateSelectShow,
      'selectEpisode': stateSelectEpisode,
      'setSearchTerm': stateSetSearchTerm,
      'setPreferences': stateSetPreferences
    };

    return MaterialApp(
        title: 'Comfy',
        theme:
            ThemeData(appBarTheme: const AppBarTheme(color: Color(0xff1b1b1b))),
        home: OrientationBuilder(builder: (_, orientation) {
          return WillPopScope(
              onWillPop: () => processPop(orientation),
              child: Scaffold(
                  backgroundColor: const Color(0xff151515),
                  appBar: PreferredSize(
                      preferredSize:
                          Size.fromHeight(MediaQuery.of(_).padding.top + 80),
                      child: Visibility(
                          visible: orientation == Orientation.portrait,
                          child: AppBar(
                              flexibleSpace: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                SizedBox(
                                    height: MediaQuery.of(_).padding.top + 10),
                                HeaderWidget(actions: actions),
                                const SizedBox(height: 10),
                                SubHeaderWidget(actions: actions)
                              ])))),
                  body: buildRoute(actions, orientation)));
        }));
  }

  StatelessWidget buildRoute(
      Map<String, Function> actions, Orientation orientation) {
    StatelessWidget route;
    switch (state.route) {
      case '/':
        route = HomeRoute(state: state, actions: actions);
        break;

      case '/all':
        route = AllRoute(state: state, actions: actions);
        break;

      case '/settings':
        route = SettingsRoute(state: state, actions: actions);
        break;

      case '/offline':
        route = OfflineRoute(state: state, actions: actions);
        break;

      default:
        route = NotFoundRoute(state: state, actions: actions);
        break;
    }
    if (state.route.startsWith("/shows/")) {
      route = ShowRoute(state: state, actions: actions);
    }
    if (state.route.startsWith("/episodes/")) {
      route = EpisodeRoute(
          state: state, orientation: orientation, actions: actions);
    }

    return route;
  }

  Future<bool> processPop(Orientation orientation) async {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      return false;
    }
    if (state.route.startsWith("/episodes/")) {
      String id = state.route.substring("/episodes/".length);
      Episode? episode = state.episodes[id];
      if (episode == null) {
        stateGoToRoute('/');
      } else {
        stateGoToRoute('/shows/${episode.show}');
      }

      return false;
    }
    switch (state.route) {
      case '/':
        return true;
    }

    stateGoToRoute('/');
    return false;
  }

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  @override
  void reassemble() {
    super.reassemble();
    setupApp();
  }

  void setupApp() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    state.packageInfo = await PackageInfo.fromPlatform();
    state.offlineLocations.clear();
    state.offlineLocations.add((await getApplicationDocumentsDirectory()).path);
    state.offlineLocations.addAll(
        (await getExternalStorageDirectories())?.map((e) => e.path) ?? []);
    state.sharedPreferences = await SharedPreferences.getInstance();
    state.preferences.skipToPlayer =
        state.sharedPreferences?.getBool("skipToPlayer") ?? false;
    state.preferences.apiEndpoint =
        state.sharedPreferences?.getString("apiEndpoint") ??
            "https://api.comfy.lamkas.dev";
    state.preferences.imageEndpoint =
        state.sharedPreferences?.getString("imageEndpoint") ??
            "https://image.comfy.lamkas.dev";
    state.preferences.vaporeonEndpoint =
        state.sharedPreferences?.getString("vaporeonEndpoint") ??
            "https://vaporeon.comfy.lamkas.dev";
    state.preferences.dev = state.sharedPreferences?.getBool("dev") ?? false;
    if (state.preferences.dev) {
      HttpOverrides.global = DevelopmentHttpOverrides();
    }
    state.preferences.offlineModeLocation =
        state.sharedPreferences?.getString("offlineModeLocation");
    if (state.preferences.offlineModeLocation != null) {
      state.offlineManifest = await loadOfflineManifest(state);
      if (!FlutterDownloader.initialized) {
        await FlutterDownloader.initialize(debug: true);
        IsolateNameServer.registerPortWithName(
            state.offlineDownloaderPort.sendPort, 'downloader_send_port');
        state.offlineDownloaderPort.listen((dynamic data) {
          setState(() {
            OfflineTaskState taskState = OfflineTaskState.fromJson(data);
            state.offlineTasks[taskState.id]?.state = taskState;
          });
        });
        FlutterDownloader.registerCallback(downloadCallback);
      }
    }

    List<Show> showList = await fetchShows(state);
    setState(() {
      for (var e in showList) {
        state.shows[e.id] = e;
      }
    });
  }

  void stateGoToRoute(String route) {
    setState(() {
      state.goToRoute(route);
    });
  }

  void stateSelectShow(String id) async {
    List<Episode> episodeList = await fetchEpisodes(state, id);
    setState(() {
      state.selectShow(id);
      for (var e in episodeList) {
        state.episodes[e.id] = e;
        state.offlineTasks["0"] = OfflineTask("0", e,
            OfflineTaskState("0", DownloadTaskStatus.running.value, 20));
      }
    });
  }

  void stateSelectEpisode(String id) async {
    List<Segment> segmentList = await fetchSegments(state, id);
    setState(() {
      state.selectEpisode(id);
      for (var e in segmentList) {
        state.segments[e.id] = e;
      }
    });

    if (state.preferences.skipToPlayer) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  void stateSetSearchTerm(String searchTerm) {
    setState(() {
      state.setSearchTerm(searchTerm);
    });
  }

  void stateSetPreferences(Preferences preferences) {
    setState(() {
      state.preferences = preferences;
    });

    state.sharedPreferences?.setBool("skipToPlayer", preferences.skipToPlayer);
    state.sharedPreferences?.setString("apiEndpoint", preferences.apiEndpoint);
    state.sharedPreferences
        ?.setString("imageEndpoint", preferences.imageEndpoint);
    state.sharedPreferences
        ?.setString("vaporeonEndpoint", preferences.vaporeonEndpoint);
    state.sharedPreferences?.setBool("dev", preferences.dev);
    if (preferences.offlineModeLocation != null) {
      state.sharedPreferences?.setString(
          "offlineModeLocation", preferences.offlineModeLocation ?? "");
    }
  }
}
