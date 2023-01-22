import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:policesystem/admin_component/menu.dart';
import 'package:policesystem/api/home.dart';
import 'package:policesystem/api/police_api.dart';
import 'package:policesystem/api/user_data_table_api.dart';
import 'package:policesystem/admin_component/floating_action_button_components.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/home.dart';
import 'package:policesystem/model/home_model.dart';
import 'package:policesystem/model/police_model.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  State<UserPanel> createState() => _UserPanelState();
}

testWindowSize() async {
  await DesktopWindow.setMaxWindowSize(const Size(1600, 900));
  await DesktopWindow.setMinWindowSize(const Size(1280, 720));
}

class _UserPanelState extends State<UserPanel> {
  final isDialOpen = ValueNotifier(false);
  Home? home;
  List<Police> policeOfficers = [];

  @override
  void initState() {
    super.initState();
    testWindowSize();
    getCounters();
  }

  void getCounters() async {
    final homeTemp = await fetchHomepageCounts();
    setState(() {
      home = homeTemp;
    });
  }

  void getPoliceOfficers() async {
    final tempPoliceOfficers = await fetchPolice();
    setState(() {
      policeOfficers = tempPoliceOfficers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("HOME PANEL"),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.login_rounded),
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.people,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Users",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                      height: 32.0,
                                    ),
                                    Text(
                                      (home?.users ?? '').toString(),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 83, 163, 87)),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Flexible(
                                child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.article,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Police Officers",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                      height: 32.0,
                                    ),
                                    Text(
                                      (home?.police ?? '').toString(),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 233, 157, 57)),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Flexible(
                                child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.article,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Applicants",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                      height: 32.0,
                                    ),
                                    Text(
                                      (home?.applicants ?? '').toString(),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 233, 157, 57)),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        //Data table =========================
                        Container(
                          child: FutureBuilder<List<Police>>(
                            future: fetchPolice(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // print(fetchUsers());
                                List<Police>? data = snapshot.data;
                                // print(data);
                                if (data != null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          DataTable(
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                              (states) => const Color.fromARGB(
                                                  209, 23, 41, 146),
                                            ),

                                            columns: const [
                                              DataColumn(
                                                  label: Text(
                                                'ID',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'First Name',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Middle Name',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Last Name',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Contact Number',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Rank',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Position',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ],
                                            // rows: List.generate(
                                            //   results.length,
                                            //   (index) => _getDataRow(
                                            //     index,
                                            //     results[index],
                                            //   ),
                                            // ),
                                            rows: data
                                                .map((user) => DataRow(cells: [
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.id.toString(),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.first_name,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.middle_name,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.last_name,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.contact_no,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.rank ?? '',
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )),
                                                      DataCell(Container(
                                                        width: 100,
                                                        child: Text(
                                                          user.position ?? '',
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ))
                                                    ]))
                                                .toList(),
                                            showBottomBorder: true,
                                          ),
                                        ],
                                      ));
                                } else {
                                  return Row(
                                    children: const <Widget>[
                                      SizedBox(
                                        // ignore: sort_child_properties_last
                                        child: CircularProgressIndicator(),
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(40),
                                        child: Text('2'),
                                        // child: Text('No Data Found...'),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      // ignore: sort_child_properties_last
                                      child: CircularProgressIndicator(),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(40),
                                      child: Text('1'),
                                      // child: Text('No Data Found...'),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
        drawer: const Drawer(
          //====Navigation Bar====
          child: const AdminMenu(),
        ),
        floatingActionButton: Speed_Dial(),
      ),
    );
    // return widget
  }
}
