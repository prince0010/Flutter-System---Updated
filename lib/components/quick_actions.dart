import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class QuickActionItem {
  final Widget icon;
  final String text;
  final VoidCallback callback;

  QuickActionItem(
      {required this.icon, required this.text, required this.callback});
}

class QuickActions extends StatefulWidget {
  const QuickActions({super.key, required this.actions});

  final List<QuickActionItem> actions;

  @override
  State<QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        icon: Icons.share,
        spaceBetweenChildren: 12,
        closeManually: false,
        animatedIcon: AnimatedIcons.menu_close,
        children: widget.actions
            .map(
              (e) => SpeedDialChild(
                  child: e.icon,
                  label: e.text,
                  onTap: () {
                    e.callback();
                  },
                  backgroundColor: Colors.orange),
            )
            .toList());
  }
}
