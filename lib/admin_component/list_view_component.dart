import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:policesystem/adminPanels/barangay_panel.dart';
import 'package:policesystem/adminPanels/co_panel.dart';
import 'package:policesystem/adminPanels/cr_panel.dart';
import 'package:policesystem/adminPanels/police_panel.dart';
import 'package:policesystem/adminPanels/pos_panel.dart';
import 'package:policesystem/adminPanels/pur_panel.dart';
import 'package:policesystem/adminPanels/rank_panel.dart';
import 'package:policesystem/adminPanels/home_panel.dart';
import 'package:policesystem/adminPanels/zone_panel.dart';
import 'package:policesystem/adminPanels/user_panel.dart';
import 'package:policesystem/adminPanels/admin_police_panel.dart';

class List_view extends StatefulWidget {
  @override
  State<List_view> createState() => _List_viewState();
}

class _List_viewState extends State<List_view> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.supervised_user_circle),
          title: const Text("Users"),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DataPage(),
            //   ),
            // );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.local_police),
          title: const Text("Police"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Policepanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.badge),
          title: const Text("Rank"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Rankpanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.folder_copy),
          title: const Text("POS"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pospanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.location_on_rounded),
          title: const Text("Zone"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZonePanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: Icon(Icons.location_on_rounded),
          title: const Text("Barangay"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarangayPanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.storage),
          title: const Text("PUR"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PurPanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.folder_copy),
          title: const Text("CR"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CrPanel(),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: const Icon(Icons.folder_copy),
          title: const Text("CO"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoPanel(),
              ),
            );
          },
        ),
      ],
    );
  }
}
