import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
// import 'package:pdf/src/pdf/colors.dart';
import 'package:pdf/widgets.dart';
import 'package:policesystem/commons.dart';
import 'package:policesystem/model/police_clearance_details.dart';
import 'package:printing/printing.dart';

Text generaText(
  String text, {
  String? color,
  double fontSize = 8,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color != null ? PdfColor.fromHex(color) : null,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

Row generateRow({required dynamic label, required dynamic value}) {
  return Row(
    children: [
      SizedBox(
        width: 70,
        child: label is String
            ? generaText(
                label,
                fontWeight: FontWeight.normal,
                fontSize: 8,
              )
            : label,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30, right: 10),
        child: generaText(':'),
      ),
      if (value is String) generaText(value),
      if (value is Widget) value,
    ],
  );
}

Widget generateSubRow(Widget initialWidget, Widget secondaryWidget) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: initialWidget,
        ),
        secondaryWidget,
      ],
    ),
  );
}

SizedBox spacer() => SizedBox(height: 10);

void generatePdf(
    {required PoliceClearanceDetails details,
    required Map<String, dynamic> otherDetails}) async {
  final pdf = Document();

  final technicalLogo = MemoryImage(
    (await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List(),
  );

  final pnpLogo = MemoryImage(
    (await rootBundle.load('assets/technical_logo2.png')).buffer.asUint8List(),
  );

  final picture =
      await networkImage('$baseUrl/image/${otherDetails['applicant_img']}');

  final signature =
      await networkImage('$baseUrl/image/${otherDetails['applicant_sig']}');

  // print(signature);

  pdf.addPage(
    Page(
      pageFormat: const PdfPageFormat(
        8.5 * PdfPageFormat.inch,
        11 * PdfPageFormat.inch,
        marginTop: .25 * PdfPageFormat.inch,
        marginBottom: .25 * PdfPageFormat.inch,
      ),
      build: (Context context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.25 * PdfPageFormat.inch,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1 * PdfPageFormat.inch,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          child: Image(pnpLogo),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                generaText(
                                  'Republic of the Philippines',
                                ),
                                generaText(
                                  'NATIONAL POLICE COMMISSION',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                                generaText(
                                  'PHILIPPINE NATIONAL POLICE',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                                generaText(
                                  'EL SALVADOR CITY POLICE STATION',
                                  fontWeight: FontWeight.bold,
                                  color: '0000FF',
                                ),
                                generaText(
                                  'POBLACION, EL SALVADOR CITY, MISAMIS ORIENTAL',
                                  fontWeight: FontWeight.normal,
                                ),
                                generaText(
                                  'Tel. (088) 555-0317 / 0975-119-8833 e-mail: elsalvador_pnp@yahoo.com',
                                  color: '0000FF',
                                ),
                                generaText(
                                  'POLICE CLEARANCE CERTIFICATE',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: 'FF0000',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          child: Image(technicalLogo),
                        ),
                      ],
                    ),
                  ),
                  spacer(),
                  generaText(
                    'PH8-ESCPS-2022-1-436',
                    fontSize: 8,
                    color: 'FF0000',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: generaText('TO WHOM IT MAY CONCERN:'),
                      ),
                      generaText('Date: 19-Oct-2022',
                          fontWeight: FontWeight.bold),
                      SizedBox(width: 30),
                    ],
                  ),
                  spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: generaText(
                                '                   This is to certify that the person, whose photo, signature and right thumbmark that appear herein, has requested a criminal/derogatory record check from this office with the following finding/s:',
                                color: '0000FF',
                                fontSize: 8,
                              ),
                            ),
                            spacer(),
                            generateRow(
                              label: generaText(
                                'Full Name',
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                              value: generaText(
                                '${details.applicant.firstName} ${details.applicant.middleName} y ${details.applicant.lastName}',
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                            generateRow(
                              label: 'Address',
                              // label: 'Address',
                              value:
                                  'Zone 3, Himalaya, El Salvador City, Misamis Oriental',
                              // 'Zone 3, Himaya, El Salvador City, Misamis Oriental',
                              //barangay added in the generate Row !!TRY LANG PAG DILI THEN TRY LAIN BALIK!!
                              // value:
                              // '${details.barangay.name} ${details.zone.name}',
                            ),
                            generateRow(
                              label: 'DOB / POB',
                              value: generateSubRow(
                                generaText(details.applicant.dateOfBirth),
                                generaText(details.applicant.placeOfBirth),
                              ),
                            ),
                            generateRow(
                              label: 'Sex / C.S',
                              value: generateSubRow(
                                generaText(details.applicant.sex),
                                generaText(details.applicant.civilStatus),
                              ),
                            ),
                            generateRow(
                              label: 'Nationality / Height',
                              value: generateSubRow(
                                generaText(
                                  '${details.applicant.nationality} ${details.applicant.height}',
                                ),

                                // generaText('AGE: ${details.applicant.age}'),

                                generaText(
                                  'AGE: ${details.applicant.height} YEARS OLD',
                                ),
                              ),
                            ),
                            // generateRow(
                            //   label: 'Age',
                            //   value: details.applicant.age,
                            // ),
                            generateRow(
                              label: 'Mobile no.',
                              value: details.applicant.contactNo,
                            ),
                            generateRow(
                              label: generaText(
                                'Purpose',
                                fontWeight: FontWeight.bold,
                              ),
                              value: details.purpose.name,
                            ),
                            generateRow(
                              label: generaText(
                                'FINDINGS',
                                fontWeight: FontWeight.bold,
                              ),
                              value:
                                  'NO CRIMINAL/DEROGATORY RECORD ON FILE AS OF THIS DATE',
                            ),
                            spacer(),
                            generateRow(
                              label: 'CC #',
                              value: details.ctc.ctcNumber,
                            ),
                            generateRow(
                              label: 'ISSUED ON',
                              value: details.ctc.dateIssue,
                            ),
                            generateRow(
                              label: 'ISSUED AT',
                              value: details.ctc.placeIssue,
                            ),
                            generateRow(
                              label: 'OR DATE',
                              value: generaText(
                                details.payment.or_number,
                                fontWeight: FontWeight.bold,
                                color: 'FF0000',
                              ),
                            ),
                            generateRow(
                              label: 'Amount Paid',
                              value: 'Php ${details.payment.payment}',
                            ),
                          ],
                        ),
                      ),
                      //Signature of 2 Police
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //Trying Crossaxisalignment.end to put the police name to the vertical bottom
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Image(
                                  signature,
                                  width: PdfPageFormat.inch,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: PdfPageFormat.inch,
                                  height: PdfPageFormat.inch,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    'First Police Signature',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: PdfColor.fromHex('0000FF'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //End of 2 police signature
                      Column(
                        children: [
                          Container(
                            width: PdfPageFormat.inch,
                            height: PdfPageFormat.inch,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: Image(
                              picture,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: PdfPageFormat.inch,
                            height: PdfPageFormat.inch,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Right Thumbmark',
                                style: TextStyle(
                                  color: PdfColor.fromHex('0000FF'),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 7,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: PdfPageFormat.inch,
                            child: Column(
                              children: [
                                Image(
                                  signature,
                                  width: PdfPageFormat.inch,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: PdfPageFormat.inch,
                                  height: PdfPageFormat.inch,
                                  decoration: const BoxDecoration(
                                    border: Border(top: BorderSide(width: 1)),
                                  ),
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    'SIGNATURE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: PdfColor.fromHex('0000FF'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              // alignment: Alignment.topRight,
              top: 10,
              right: 30,
              child: SizedBox(
                width: 50,
                height: 50,
                child: BarcodeWidget(
                  color: PdfColor.fromHex("#000000"),
                  barcode: Barcode.qrCode(),
                  data: "My data",
                ),
              ),
            ),
          ],
        );
      },
    ),
  );

  // final file = File('certificate.pdf');
  // await file.writeAsBytes(await pdf.save());

  // final output = await getTemporaryDirectory();
  // final file = File('${output.path}/certificate.pdf');
  // await file.writeAsBytes(await pdf.save());

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );

  // return file;
}
