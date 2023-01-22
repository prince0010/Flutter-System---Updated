import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:policesystem/api/cr_panel_api.dart';
import 'package:policesystem/api/pcc_api.dart';
import 'package:policesystem/cashier/payment_form.dart';
import 'package:policesystem/clerk/applicant_form.dart';
import 'package:policesystem/components/quick_actions.dart';
import 'package:policesystem/model/applicant.dart';
import 'package:policesystem/model/police_clearance_details.dart';
import 'package:policesystem/panel/camera_panel.dart';
import 'package:policesystem/panel/form_panel.dart';
// import 'package:policesystem/model/clerk_data_table_model.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:policesystem/pdf_generator/pdf_generator.dart';

import '../commons.dart';

class ClerkHome extends StatefulWidget {
  const ClerkHome({Key? key}) : super(key: key);

  @override
  State<ClerkHome> createState() => _ClerkHome();
}

// @override
// Widget build(BuildContext context => Scaffold
// );

class Debouncer {
  final int milliseconds;
  Debouncer({required this.milliseconds});

  late VoidCallback action;
  late Timer _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _ClerkHome extends State<ClerkHome> {
  late bool sort;
  final _debouncer = Debouncer(milliseconds: 500);

  List<PoliceClearanceDetails> applicants = [];
  PoliceClearanceDetails? selectedApplicant;
  List<int> selectedApplicants = [];
  List<Applicant> filteredApplicants = [];

  @override
  void initState() {
    sort = false;
    super.initState();
    testWindowSize();
    getApplicants();
  }

  void getApplicants() async {
    final tempApplicants = await getPccd();
    if (tempApplicants != null) {
      setState(() {
        applicants = tempApplicants;
      });
    }
  }

  testWindowSize() async {
    // await DesktopWindow.setMaxWindowSize(const Size(1600, 900));
    await DesktopWindow.setMinWindowSize(const Size(1280, 720));
  }

//Sorting sa firstname
  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        // _users.sort((a, b) => a.firstname.compareTo(b.firstname));
      } else {
        // _users.sort((a, b) => b.firstname.compareTo(a.firstname));
      }
    }
  }

  void validateApplicant(BuildContext context) async {
    if (selectedApplicant!.status == 'pending payment') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentForm(
            applicant: selectedApplicant!,
          ),
        ),
      ).then((value) {
        getApplicants();
        setState(() {
          selectedApplicant = null;
        });
      });
    } else {
      showLoaderDialog(context);
      final criminalRecords = await fetchCr(params: {
        'first_name': selectedApplicant!.applicant.firstName,
        'middle_name': selectedApplicant!.applicant.middleName,
        'last_name': selectedApplicant!.applicant.lastName,
      });
      // print(criminalRecords);
      await editPccd(selectedApplicant!.id, {
        'status': criminalRecords.isNotEmpty
            ? 'under investigation'
            : 'pending for printing'
      });

      Navigator.of(context).pop();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Validation'),
              content: Text(
                criminalRecords.isEmpty
                    ? 'NO CRIMINAL/DEROGATORY RECORD ON FILE AS OF THIS DATE'
                    : 'ALERT: HIT!',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                )
              ],
            );
          }).then((value) {
        getApplicants();
        setState(() {
          selectedApplicant = null;
        });
      });
    }
  }

  String getPayment(PoliceClearanceDetails details) {
    if (details.status == 'pending payment') return '-';
    return details.payment.payment;
  }

  String getOR(PoliceClearanceDetails details) {
    if (details.status == 'pending payment') return '-';
    return details.payment.or_number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clerk'),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      floatingActionButton: QuickActions(actions: [
        QuickActionItem(
          icon: const Icon(Icons.person),
          text: 'Add Applicant',
          callback: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApplicantForm()))
                .then((value) => getApplicants());
          },
        ),
        // QuickActionItem(
        //   icon: const Icon(Icons.person),
        //   text: 'Camera',
        //   callback: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const CameraPanel(),
        //       ),
        //     ).then((value) => getApplicants());
        //   },
        // ),
        if (selectedApplicant != null) ...[
          if (selectedApplicant!.status != 'pending for printing')
            QuickActionItem(
                icon: const Icon(Icons.person),
                text: 'Edit Applicant',
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplicantForm(
                                applicant: selectedApplicant,
                              ))).then((value) => getApplicants());
                }),
          QuickActionItem(
              icon: const Icon(Icons.person),
              text: 'Delete Applicant',
              callback: () {
                deletePcc(selectedApplicant!.id)
                    .then((value) => getApplicants());
              }),
          if (selectedApplicant!.status != 'pending for printing')
            QuickActionItem(
                icon: const Icon(Icons.person),
                text: 'Validate Applicant',
                callback: () {
                  validateApplicant(context);
                }),
          if (selectedApplicant!.status == 'pending for printing')
            QuickActionItem(
                icon: const Icon(Icons.person),
                text: 'Print Certificate',
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PdfGenerator(
                                applicant: selectedApplicant!,
                              ))).then((value) => getApplicants());
                }),
        ],
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          // TextField(
          //   maxLength: 50,
          //   decoration: const InputDecoration(
          //     icon: Icon(Icons.search),
          //     labelText: 'Search',
          //     hintText: 'Input text',
          //     labelStyle: TextStyle(
          //       color: Color.fromARGB(255, 0, 56, 238),
          //     ),
          //     helperText: 'Search Data',
          //     suffixIcon: Icon(
          //       Icons.check_circle,
          //     ),
          //     enabledBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Color.fromARGB(255, 0, 56, 238)),
          //     ),
          //   ),
          //   onChanged: (value) {
          //     //go to debouncer class
          //   },
          // ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 10,
                    columns: const [
                      DataColumn(
                        label: Text("First Name"),

                        // onSort: (columnIndex, ascending) {
                        //   setState(() {
                        //     sort = !sort;
                        //   });
                        //   onSortColumn(columnIndex, ascending
                      ),
                      DataColumn(
                        label: Text("Middle Name"),
                        numeric: false,
                        tooltip: "Middle Name",
                      ),
                      DataColumn(
                        label: Text("Last Name"),
                        numeric: false,
                        tooltip: "Last Name",
                      ),
                      DataColumn(
                        label: Text('Contact Num.'),
                        numeric: false,
                        tooltip: "Contact Number",
                      ),
                      DataColumn(
                        label: Text("Date of Birth"),
                        numeric: false,
                        tooltip: "Date of Birth",
                      ),
                      DataColumn(
                        label: Text("Place of Birth"),
                        numeric: false,
                        tooltip: "Place of Birth",
                      ),
                      DataColumn(
                        label: Text("Civil Status"),
                        numeric: false,
                        tooltip: "Civil Status",
                      ),
                      DataColumn(
                        label: Text("Height"),
                        numeric: false,
                        tooltip: "Height",
                      ),
                      DataColumn(
                        label: Text("Sex"),
                        numeric: false,
                        tooltip: "Sex",
                      ),
                      DataColumn(
                        label: Text("Nationality"),
                        numeric: false,
                        tooltip: "Nationality",
                      ),
                      DataColumn(
                        label: Text("Address"),
                      ),
                      DataColumn(
                        label: Text("Purpose"),
                      ),
                      DataColumn(
                        label: Text("CTC"),
                      ),
                      DataColumn(
                        label: Text("Issued On"),
                      ),
                      DataColumn(
                        label: Text("Issued At"),
                      ),
                      DataColumn(
                        label: Text("OR NO."),
                      ),
                      DataColumn(
                        label: Text("Payment"),
                      ),
                      DataColumn(
                        label: Text("Status"),
                      ),
                    ],
                    rows: applicants
                        .map(
                          (applicant) => DataRow(
                              selected: selectedApplicant == applicant,
                              onSelectChanged: (isSelected) {
                                setState(() {
                                  selectedApplicant =
                                      isSelected! ? applicant : null;
                                });
                                // if (isSelected!) {
                                //   if (!selectedApplicants
                                //       .contains(applicant.id)) {
                                //     selectedApplicants.add(applicant.id);
                                //   } else {
                                //     selectedApplicants.remove(applicant.id);
                                //   }
                                // } else {
                                //   selectedApplicants.remove(applicant.id);
                                // }

                                // setState(() {});
                                // onSelectedRow(b!, user);
                              },
                              cells: [
                                DataCell(
                                  Text(applicant.applicant.firstName),
                                ),
                                DataCell(
                                  Text(applicant.applicant.middleName),
                                ),
                                DataCell(
                                  Text(applicant.applicant.lastName),
                                ),
                                DataCell(
                                  Text(applicant.applicant.contactNo),
                                ),
                                DataCell(
                                  Text(applicant.applicant.dateOfBirth),
                                ),
                                DataCell(
                                  Text(applicant.applicant.placeOfBirth),
                                ),
                                DataCell(
                                  Text(
                                    applicant.applicant.civilStatus
                                        .toCapitalized(),
                                  ),
                                ),
                                DataCell(
                                  Text(applicant.applicant.height),
                                ),
                                DataCell(
                                  Text(applicant.applicant.sex.toCapitalized()),
                                ),
                                DataCell(
                                  Text(applicant.applicant.nationality),
                                ),
                                DataCell(
                                  Text(
                                      applicant.applicant.addressId.toString()),
                                ),
                                DataCell(
                                  Text(applicant.purpose.name),
                                ),
                                DataCell(
                                  Text(applicant.ctc.ctcNumber),
                                ),
                                DataCell(
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(applicant.ctc.dateIssue),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(applicant.ctc.placeIssue),
                                ),
                                DataCell(
                                  Text(
                                    getOR(applicant),
                                  ),
                                ),
                                DataCell(
                                  Text(getPayment(applicant)),
                                ),
                                DataCell(
                                  Text(applicant.status.toTitleCase()),
                                ),
                              ]),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(140.0),
          //         child: OutlinedButton(
          //             onPressed: () {},
          //             child: Text('SELECTED ${selectedApplicants.length}')),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
