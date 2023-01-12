/* Base */
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final Map<String, Function> actions;

  const HeaderWidget({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              const SizedBox(width: 10),
              ClipRRect(
                  child: Image.asset(
                    'assets/icons/icon-192x192.png',
                    width: 32,
                    height: 32,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              const Text(
                'Comfy',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ]));
  }
}
