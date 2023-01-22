import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:policesystem/pdf/model/invoice.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/technical_logo.png'))
          .buffer
          .asUint8List());
  final imageLogo2 = MemoryImage(
      (await rootBundle.load('assets/technical_logo2.png'))
          .buffer
          .asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 80,
                    width: 100,
                    child: Image(imageLogo2),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'EL SALVADOR POLICE STATION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  height: 80,
                  width: 100,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(
              child: Center(
                child: Text(
                  'POBLACION, EL SALVADOR CITY, MISAMIS ORIENTAL',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  'Tel: (088) 555-0317 / 0975-119-8833',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  'Email: elsalvador_pnp@yahoo.com',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 7,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  'POLICE CLEARANCE CERTIFICATE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),
            // Container(child: Text('PH8 ESCPS-{$Year}-{$Month}'),),
            //   Container(child: Text('{$TotalofApplicants}'),),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Text(
                    'PH8 ESCPS-2022-9-',
                  ),
                  SizedBox(width: 5),
                  Text('500 Applicants',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Text('TO WHOM IT MAY CONCERN',
                        style: TextStyle(fontSize: 10)),
                    SizedBox(width: 230.0),
                    Text('Date:  $formattedDate'),
                  ],
                )),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '         This is to certify that the person, whos photo, signature and right thumbmark that appear herein has requested a criminal/derogatory record check from this office with the following finding/s.',
                  ),
                ),
              ],
            ),

            Container(height: 10),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(5),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'Applicant',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                      ),
                      Expanded(
                        child: PaddedText(e.customername),
                        flex: 1,
                      )
                    ],
                  ),
                ),

                // TableRow(
                //   children: [
                //     PaddedText('TAX', align: TextAlign.right),
                //     // PaddedText(
                //     //     '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     PaddedText('TOTAL', align: TextAlign.right),
                //     // PaddedText(
                //     //     '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                //   ],
                // )
              ],
            ),
            SizedBox(height: 10.0),

            Container(height: 3),
            Table(border: TableBorder.all(color: PdfColors.black), children: [
              TableRow(
                children: [
                  PaddedText('Account Number'),
                  PaddedText(
                    'Number',
                  )
                ],
              ),
              TableRow(
                children: [
                  PaddedText(
                    'CC#',
                  ),
                  PaddedText(
                    '15977159',
                  )
                ],
              ),
              //     TableRow(
              //       children: [
              //         PaddedText(
              //           'Total Amount to be Paid',
              //         ),
              //         // PaddedText(
              //         //     '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
              //       ],
              //     )
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsets.all(30),
              //   child: Text(
              //     'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
              //     style: Theme.of(context).header3.copyWith(
              //           fontStyle: FontStyle.italic,
              //         ),
              //     textAlign: TextAlign.center,
              //   ),
            ]),
            // )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
        style: const TextStyle(
          fontSize: 10.0,
        ),
      ),
    );
