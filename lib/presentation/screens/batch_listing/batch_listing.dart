import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/error_message_with_retry.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/batch_listing/batch_listing_controller.dart';
import 'package:folldy_student/utils/constants.dart';

import 'components/batch_item.dart';

class BatchListing extends StatelessWidget {
  const BatchListing({
    Key? key,
    required this.navigateToDashboard,
  }) : super(key: key);

  final VoidCallback navigateToDashboard;

  @override
  Widget build(BuildContext context) {
    BatchListingController batchListingController = Get.find();
    batchListingController.getAllBatches();
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 300,
          leading: TextButton(
              onPressed: navigateToDashboard,
              child: Row(children: const [
                Icon(CupertinoIcons.chevron_back,
                    color: Colors.red, size: defaultPadding),
                Text("Board", style: TextStyle(fontSize: 18, color: jumpoGrey)),
              ])),
          title: Row(
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () => Get.toNamed(AppRoute.addEditBatch,
                      arguments: batchListingController.getAllBatches),
                  icon: const Icon(CupertinoIcons.add_circled))
            ],
          ),
        ),
        body: AnimatedBuilder(
            animation: batchListingController,
            builder: (context, child) {
              return NetworkResource(
                error: batchListingController.appError,
                isLoading: batchListingController.isLoading,
                errorWidget: Builder(builder: (context) {
                  return ErrorMessageWithRetry(
                      error: batchListingController.appError!,
                      retry: batchListingController.retry);
                }),
                child: ListView(
                  padding: const EdgeInsets.all(defaultPaddingSmall),
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: defaultPadding,
                  //     crossAxisSpacing: defaultPadding),
                  children: [
                    // AddBatchButton(
                    //     refreshBatches: batchListingController.getAllBatches),
                    ...batchListingController.batches.map((batch) {
                      return BatchItem(
                        batch: batch,
                      );
                    }),
                  ],
                ),
              );
            }));
  }
}
