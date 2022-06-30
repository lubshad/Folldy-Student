import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/error_message_with_retry.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:folldy_student/utils/constants.dart';

import 'components/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key? key,
    required this.navigateToUpdates,
  }) : super(key: key);

  final VoidCallback navigateToUpdates;

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find();
    dashboardController.getData();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoute.profileScreen),
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultPaddingSmall),
                  child: Container(
                    width: defaultPaddingLarge,
                    height: defaultPaddingLarge,
                    // backgroundColor: Colors.transparent,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.search))
          ],
        ),
        actions: [
          TextButton(
            onPressed: navigateToUpdates,
            child: Row(children: const [
              Text("Updates", style: TextStyle(color: jumpoGrey, fontSize: 18)),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  CupertinoIcons.chevron_forward,
                  color: Colors.red,
                  size: defaultPadding,
                ),
              )
            ]),
          )
        ],
      ),
      body: AnimatedBuilder(
          animation: dashboardController,
          builder: (context, child) {
            return NetworkResource(
              error: dashboardController.appError,
              isLoading: dashboardController.isLoading,
              errorWidget: Builder(builder: (context) {
                return ErrorMessageWithRetry(
                    error: dashboardController.appError!,
                    retry: dashboardController.retry);
              }),
              child: Builder(builder: (context) {
                return DashboardBody(
                  dashboardDetails: dashboardController.dashboardDetails!,
                );
              }),
            );
          }),
    );
  }
}
