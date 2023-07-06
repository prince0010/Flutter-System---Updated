import 'package:flutter/material.dart';
import 'package:policesystem/api/pcc_api.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/components/quick_actions.dart';
import 'package:policesystem/model/police_clearance_details.dart';

class CashierPanel extends StatefulWidget {
  const CashierPanel({super.key});

  @override
  State<CashierPanel> createState() => _CashierPanelState();
}

class _CashierPanelState extends State<CashierPanel> {
  List<PoliceClearanceDetails> applicants = [];
  PoliceClearanceDetails? selectedApplicant;
  @override
  void initState() {
    getApplicants();
    super.initState();
  }

  void getApplicants() async {
    final tempApplicants = await getPccd();
    if (tempApplicants != null) {
      setState(() {
        applicants = tempApplicants;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashier'),
        centerTitle: false,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      floatingActionButton: selectedApplicant != null
          ? QuickActions(
              actions: [
                QuickActionItem(
                  icon: const Icon(Icons.person),
                  text: 'Confirm',
                  callback: () async {
                    showLoaderDialog(context);
                    await editPccd(selectedApplicant!.id,
                        {'status': 'pending confirmation'});

                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          : null,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: DataTable(
              horizontalMargin: 12,
              columnSpacing: 12,
              columns: const [
                DataColumn(
                  label: Text("Id"),
                ),
                DataColumn(
                  label: Text("First Name"),
                ),
                DataColumn(
                  label: Text("Middle Name"),
                ),
                DataColumn(
                  label: Text("Last Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
              ],
              rows: applicants
                  .map(
                    (applicant) => DataRow(
                      selected: selectedApplicant == applicant,
                      onSelectChanged: (isSelected) {
                        setState(() {
                          selectedApplicant = isSelected! ? applicant : null;
                        });
                      },
                      cells: [
                        DataCell(
                          Text(applicant.id.toString()),
                        ),
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
                          Text(applicant.createdAt),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
