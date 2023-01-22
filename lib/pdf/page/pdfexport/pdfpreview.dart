import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:policesystem/pdf/model/invoice.dart';
import 'package:policesystem/pdf/page/pdfexport/pdf/pdfexport.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Clearance Certificate'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
