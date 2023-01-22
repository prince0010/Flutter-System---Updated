import 'package:flutter/material.dart';
import 'package:policesystem/adminPanels/barangay_panel.dart';
import 'package:policesystem/adminPanels/co_panel.dart';
import 'package:policesystem/adminPanels/cr_panel.dart';
import 'package:policesystem/adminPanels/home_panel.dart';
import 'package:policesystem/adminPanels/police_panel.dart';
import 'package:policesystem/adminPanels/pos_panel.dart';
import 'package:policesystem/adminPanels/pur_panel.dart';
import 'package:policesystem/adminPanels/rank_panel.dart';
import 'package:policesystem/adminPanels/ranks.dart';
import 'package:policesystem/adminPanels/users.dart';
import 'package:policesystem/adminPanels/zone_panel.dart';

class MenuItem {
  final Widget icon;
  final String title;
  final void Function(BuildContext context) callback;

  MenuItem({required this.icon, required this.title, required this.callback});
}

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  final List<MenuItem> menus = [
    MenuItem(
      icon: const Icon(Icons.home),
      title: 'Home',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.supervised_user_circle),
      title: 'Users',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.local_police),
      title: 'Police',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Policepanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.badge),
      title: 'Rank',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RanksPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.folder_copy),
      title: 'POS',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pospanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.location_on_rounded),
      title: 'Zone',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZonePanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.location_on_rounded),
      title: 'Barangay',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BarangayPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.storage),
      title: 'PUR',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PurPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.folder_copy),
      title: 'CR',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrPanel(),
        ),
      ),
    ),
    MenuItem(
      icon: const Icon(Icons.folder_copy),
      title: 'CO',
      callback: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoPanel(),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
      children: menus
          .map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: e.icon,
                  title: Text(e.title),
                  onTap: () => e.callback(context),
                ),
              ))
          .toList(),
    );
  }
}
