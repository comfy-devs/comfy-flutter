/* Base */
import 'package:flutter/material.dart';

class SettingsOptionTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final String value;
  final Function(String) onChanged;

  const SettingsOptionTextField(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = value;

    return SizedBox(
        height: 70,
        width: 250,
        child: Wrap(children: [
          SizedBox(
              height: 20,
              child: Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 13))),
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 12),
            onChanged: onChanged,
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff2f2f2f),
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: hintText,
                contentPadding: const EdgeInsets.only(left: 8)),
            controller: controller,
          )
        ]));
  }
}
