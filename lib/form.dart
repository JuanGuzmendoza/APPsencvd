import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:open_file/open_file.dart';
class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String pdfFile = '';

  Future<void> createPdfFile() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello World!', style: pw.TextStyle(fontSize: 20)),
        );
      },
    ));

    final bytes = await pdf.save();

    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/output.pdf');
    await file.writeAsBytes(bytes);

    setState(() {
      pdfFile = file.path;
    });
  }

  void savePdfFile() {
    OpenFile.open(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: pdfFile.isNotEmpty,
              child: Text('PDF created: $pdfFile'),
            ),
            TextButton(
              onPressed: () async {
                await createPdfFile();
                savePdfFile();
              },
              child: Text('Create PDF'),
            ),
          ],
        ),
      ),
    );
  }
}