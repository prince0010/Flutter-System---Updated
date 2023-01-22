// import 'dart:html';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class PdfApi {
//   static Future<File> generatePDF({
//     required ByteData imageSignature,
//   }) async {
//     final document = PdfDocument();
//     final page = document.pages.add();

//     drawSignature(page, imageSignature);

//     return saveFile(document);
//   }

//   static Future<File> saveFile(PdfDocument document) async {
//     final path = await getApplicationDocumentsDirectory();
//     final finalNames =
//         path.path + '/Invoice${DateTime.now().toIso8601String()}.pdf';
//     final file = File(fileNames);

//     file.writeAsBytes(document.save());
//     document.dispose();

//     return file;
//   }

//   static void drawSignature(PdfPage page, ByteData imageSignature) {
//     final pagesize = page.getClientSize();
//     final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());

//     page.graphics.drawImage(image,
//         Rect.fromLTWH(pageSize.width - 120, pageSize.width - 200, 100, 40));
//   }
// }
