import 'package:flutter/material.dart';
import 'package:policesystem/admin_component/menu.dart';
import 'package:policesystem/commons.dart';

class MainPanel extends StatefulWidget {
  const MainPanel({
    Key? key,
    required this.title,
    required this.child,
    this.floatingAction,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Widget? floatingAction;

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 18, 79, 103),
      ),
      drawer: const Drawer(
        //====Navigation Bar====
        child: AdminMenu(),
      ),
      floatingActionButton: widget.floatingAction,
      body: widget.child,
    );
  }
}
