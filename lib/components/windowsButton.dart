import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
//  this is a package you need to import and install para sa windows button

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
