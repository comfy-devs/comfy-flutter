/* Base */
import 'package:flutter/material.dart';

class SubHeaderWidget extends StatelessWidget {
  final Map<String, Function> actions;

  const SubHeaderWidget({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const n = 4;
    final w = ((MediaQuery.of(context).size.width - 20) / n) - 10;

    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          const SizedBox(width: 5),
          SizedBox(
              height: 35,
              width: w,
              child: TextButton(
                  onPressed: () => {actions['goToRoute']!('/')},
                  child: const Text('Home',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff2f2f2f))))),
          SizedBox(
              height: 35,
              width: w,
              child: TextButton(
                  onPressed: () => {actions['goToRoute']!('/all')},
                  child: const Text('All',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff2f2f2f))))),
          SizedBox(
              height: 35,
              width: w,
              child: TextButton(
                  onPressed: () => {actions['goToRoute']!('/settings')},
                  child: const Text('Settings',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff2f2f2f))))),
          SizedBox(
              height: 35,
              width: w,
              child: TextButton(
                  onPressed: () => {actions['goToRoute']!('/offline')},
                  child: const Text('Offline',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff2f2f2f)))))
        ]);
  }
}
