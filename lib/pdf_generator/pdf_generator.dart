import 'package:flutter/material.dart';
import 'package:policesystem/api/applicant_api.dart';
import 'package:policesystem/model/police_clearance_details.dart';
import 'package:policesystem/pdf_generator/generate_certificate.dart';

class PdfGenerator extends StatefulWidget {
  const PdfGenerator({super.key, required this.applicant});

  final PoliceClearanceDetails applicant;

  @override
  State<PdfGenerator> createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
  Map<String, dynamic> details = {};

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final applicantDetails =
        await getApplicantDetails(widget.applicant.applicantId);
    print(applicantDetails);
    setState(() {
      details = applicantDetails!;
    });

    generatePdf(details: widget.applicant, otherDetails: applicantDetails!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Print Certificate',
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
