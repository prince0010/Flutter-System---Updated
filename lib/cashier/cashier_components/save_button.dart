import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Confirm_Button extends StatefulWidget {
  @override
  State<Confirm_Button> createState() => _Confirm_ButtonState();
}

class _Confirm_ButtonState extends State<Confirm_Button> {
  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: const Color(0xff03dac6),
      foregroundColor: Colors.black,
      onPressed: () {
        print('Confirmed');
      },
      icon: Icon(Icons.add),
      label: Text('Confirm'),
    );
  }
}
