import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

import '../suggested_module_listing_screen/suggested_module_listing_screen.dart';
import '../trending_module_listing_screen/trending_module_listing_screen.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banking and Insurance"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(
                padding: EdgeInsets.symmetric(horizontal: defaultPaddingLarge),
                tabs: [
                  Tab(text: "Suggested"),
                  Tab(text: "Trending"),
                ]),
            Expanded(
              child: TabBarView(children: [
                SuggestedModuleListing(),
                TrendingTopicListing()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
