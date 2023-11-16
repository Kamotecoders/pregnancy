import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ViewPDFPage extends StatefulWidget {
  final String url;

  const ViewPDFPage({Key? key, required this.url}) : super(key: key);

  @override
  State<ViewPDFPage> createState() => _ViewPDFPageState();
}

class _ViewPDFPageState extends State<ViewPDFPage> {
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  Future<void> loadDocument() async {
    try {
      final loadedDocument =
          await PDFDocument.fromURL(Uri.decodeComponent(widget.url));
      setState(() {
        document = loadedDocument;
      });
    } catch (e) {
      // Handle the error, for example, show an error message or go back to the previous screen.
      print('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewer(document: document);
  }
}
