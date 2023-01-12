/* Base */
import 'package:flutter/material.dart';
import 'package:comfy/widgets/settings_option_button.dart';
import 'package:comfy/widgets/settings_option_text_field.dart';
import '../state/state.dart';

class SettingsRoute extends StatelessWidget {
  final ComfyState state;
  final Map<String, Function> actions;

  const SettingsRoute({Key? key, required this.state, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const Text("Settings",
                    style: TextStyle(fontSize: 23, color: Colors.white)),
                SettingsOptionButton(
                    text:
                        "Skip to video player: ${state.preferences.skipToPlayer ? 'Yes' : 'No'}",
                    onClick: () {
                      state.preferences.skipToPlayer =
                          !state.preferences.skipToPlayer;
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionButton(
                    text:
                        "Development mode: ${state.preferences.dev ? 'Yes' : 'No'}",
                    onClick: () {
                      state.preferences.dev = !state.preferences.dev;
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionTextField(
                    text: 'API endpoint:',
                    hintText: 'API endpoint...',
                    value: state.preferences.apiEndpoint,
                    onChanged: (text) {
                      state.preferences.apiEndpoint = text;
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionTextField(
                    text: 'Image endpoint:',
                    hintText: 'Image endpoint...',
                    value: state.preferences.imageEndpoint,
                    onChanged: (text) {
                      state.preferences.imageEndpoint = text;
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionTextField(
                    text: 'Vaporeon endpoint:',
                    hintText: 'Vaporeon endpoint...',
                    value: state.preferences.vaporeonEndpoint,
                    onChanged: (text) {
                      state.preferences.vaporeonEndpoint = text;
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionButton(
                    text: "Set official endpoints",
                    onClick: () {
                      state.preferences.apiEndpoint =
                          "https://api.comfy.lamkas.dev";
                      state.preferences.imageEndpoint =
                          "https://image.comfy.lamkas.dev";
                      state.preferences.vaporeonEndpoint =
                          "https://vaporeon.comfy.lamkas.dev";
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionButton(
                    text: "Set development endpoints",
                    onClick: () {
                      state.preferences.apiEndpoint =
                          "https://192.168.0.103:9101";
                      state.preferences.imageEndpoint =
                          "https://192.168.0.103:545";
                      state.preferences.vaporeonEndpoint =
                          "https://192.168.0.103:546";
                      actions["setPreferences"]!(state.preferences);
                    }),
                SettingsOptionButton(
                    text: "Set emulator endpoints",
                    onClick: () {
                      state.preferences.apiEndpoint = "https://10.0.2.2:9101";
                      state.preferences.imageEndpoint = "https://10.0.2.2:545";
                      state.preferences.vaporeonEndpoint =
                          "https://10.0.2.2:546";
                      actions["setPreferences"]!(state.preferences);
                    }),
                Text("Version: ${state.packageInfo?.version}",
                    style: const TextStyle(color: Colors.white, fontSize: 13))
              ]))
    ]);
  }
}
