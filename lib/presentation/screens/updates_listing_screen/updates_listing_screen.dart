import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class UpdatesListing extends StatelessWidget {
  const UpdatesListing({
    Key? key,
    required this.navigateToDashboard,
  }) : super(key: key);

  final VoidCallback navigateToDashboard;

  @override
  Widget build(BuildContext context) {
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
        // title: Row(
        //   children: [
        //     const Spacer(),
        //     IconButton(
        //         onPressed: () => Get.toNamed(AppRoute.addEditBatch,
        //             arguments: batchListingController.getAllBatches),
        //         icon: const Icon(CupertinoIcons.add_circled))
        //   ],
        // ),
      ),
      body: Container(),
    );
  }
}
