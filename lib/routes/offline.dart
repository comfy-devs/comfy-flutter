/* Base */
import 'package:flutter/material.dart';
import 'package:nyan_anime/scripts/flutter/offline.dart';
import 'package:nyan_anime/widgets/settings_option_dropdown.dart';
import '../state/state.dart';

class OfflineRoute extends StatelessWidget {
  final NyanAnimeState state;
  final Map<String, Function> actions;

  const OfflineRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OfflineTask> tasks = state.offlineTasks.values.toList();

    return ListView(children: [
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
          child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              children: [
                SettingsOptionDropdown(
                    text:
                        "Offline mode location: ${getDeviceName(state.preferences.offlineModeLocation)}",
                    items: state.offlineLocations,
                    value: state.preferences.offlineModeLocation,
                    formatText: (e) => getDeviceName(e),
                    onChanged: (e) {
                      state.preferences.offlineModeLocation = e;
                      actions["setPreferences"]!(state.preferences);
                    }),
                Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: 320,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext _context, int i) {
                          return Text(tasks[i].episode.title);
                        }))
              ]))
    ]);
  }
}
