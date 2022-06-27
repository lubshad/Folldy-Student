import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/error_message_with_retry.dart';

import 'batch_details_controller.dart';
import 'components/batch_details_body.dart';

class BatchDetailsScreen extends StatelessWidget {
  const BatchDetailsScreen({
    Key? key,
    required this.batch,
  }) : super(key: key);
  final Map<String, dynamic> batch;

  @override
  Widget build(BuildContext context) {
    BatchDetailsController batchDetailsController = BatchDetailsController();
    batchDetailsController.batch = batch;
    batchDetailsController.getData();
    DateTime start = DateTime.parse(batch["start"]);
    DateTime end = DateTime.parse(batch["end"]);
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "${batch["name"]} ${start.year} - ${end.year.toString().substring(2, 4)}")),
      body: AnimatedBuilder(
          animation: batchDetailsController,
          builder: (context, child) {
            return NetworkResource(
              error: batchDetailsController.appError,
              isLoading: batchDetailsController.isLoading,
              errorWidget: Builder(builder: (context) {
                return ErrorMessageWithRetry(
                    error: batchDetailsController.appError!,
                    retry: batchDetailsController.retry);
              }),
              child: Builder(builder: (context) {
                return BatchDetailsBody(
                    batchDetailsController: batchDetailsController);
              }),
            );
          }),
    );
  }
}
