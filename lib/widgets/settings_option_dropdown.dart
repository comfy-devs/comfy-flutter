/* Base */
import 'package:flutter/material.dart';

String defaultFormatText(String text) {
  return text;
}

class SettingsOptionDropdown extends StatelessWidget {
  final String text;
  final List<String> items;
  final String? value;
  final String Function(String) formatText;
  final Function(String?) onChanged;

  const SettingsOptionDropdown(
      {Key? key,
      required this.text,
      required this.items,
      required this.value,
      this.formatText = defaultFormatText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 250,
        child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: 250,
                  alignment: Alignment.center,
                  child: Text(text,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13))),
              Container(
                  decoration: const BoxDecoration(color: Color(0xc9424242)),
                  child: DropdownButton<String>(
                    items: items.map((v) {
                      return DropdownMenuItem<String>(
                        value: v,
                        child: Text(formatText(v)),
                      );
                    }).toList(),
                    value: value,
                    onChanged: onChanged,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color(0xc9424242),
                  )),
            ]));
  }
}
