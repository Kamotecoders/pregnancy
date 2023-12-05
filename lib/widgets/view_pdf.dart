import 'package:flutter/material.dart';
import 'package:pregnancy/models/modules.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPDF extends StatelessWidget {
  final Module module;
  const ViewPDF({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyle.primary,
        title: Text(module.name),
      ),
      body: SfPdfViewer.network(
        module.url,
      ),
    );
  }
}
