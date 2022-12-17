/* Base */
import 'package:flutter/material.dart';

class SettingsOptionButton extends StatelessWidget {
  final String text;
  final Function onClick;

  const SettingsOptionButton(
      {Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        width: 250,
        child: TextButton(
            onPressed: () => {onClick()},
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xff2f2f2f)))));
  }
}
