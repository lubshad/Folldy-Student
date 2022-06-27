import 'package:flutter/material.dart';
import 'package:folldy_student/data/core/api_constants.dart';
import 'package:folldy_utils/presentation/elements/read_mode_element.dart';

class ReadmodeScreen extends StatelessWidget {
  const ReadmodeScreen({
    Key? key,
    required this.readmodeElements,
  }) : super(key: key);

  final List<ReadModeElement> readmodeElements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                readmodeElements.length,
                (index) => ReadModeItem(
                      item: readmodeElements[index],
                      domainUrl: ApiConstants.domainMediaUrl,
                    ))),
      ),
    );
  }
}
