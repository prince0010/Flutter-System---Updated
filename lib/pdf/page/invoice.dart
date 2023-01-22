import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:policesystem/pdf/model/address.dart';
import 'package:policesystem/pdf/model/invoice.dart';
import 'package:policesystem/pdf/page/details.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);

  final users = <Invoice>[
    Invoice(
        customer: 'Prince Nagac',
        address: '123 Fake St\r\nBermuda Triangle',
        items: [
          LineItem('Full Name', 'Prince Nagac'),
          LineItem('Date of Birth', '12-01-2001 '),
          LineItem('Deployment Assistance', 'Zone 2 '),
          LineItem('Place of Birth', 'Cagayan '),
          LineItem('Sex', 'Male '),
          LineItem('Civil Status', 'Single'),
          LineItem('Nationality', 'Filipino/Chinese '),
          LineItem('Age', '21'),
          LineItem('Mobile Phone', '+(63) 965-650-7412'),
          LineItem('Purpose', 'FOR LOCAL EMPLOYMENT'),
          LineItem(
              'FINDINGS', 'NO CRIMINAL/DEROGATORY ON FILE AS OF THIS DATE'),
        ],
        name: 'Applicant Info'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView(
        children: [
          ...users.map(
            (e) => ListTile(
              title: Text(
                e.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(e.customer),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => DetailPage(invoice: e),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
