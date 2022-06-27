
import 'package:flutter/cupertino.dart';

mixin PageNavigationMixin {
  List<int> pageHistory = [0];
  int currentPageIndex = 0;

  List pageNavigationTimeLine = [];

  PageController pageController = PageController();

  navigateToPage(int page) {
    // if (isNearPage(page)) {
    //   pageController.animateToPage(page,
    //       duration: defaultAnimationDuration, curve: Curves.ease);
    // } else {
    pageController.jumpToPage(page);
    // }
    currentPageIndex = page;
  }

  bool isNearPage(int page) {
    bool isNearPage = (currentPageIndex - page).abs() == 1;
    return isNearPage;
  }

  void recordHistory(int value) {
    pageHistory.add(value);
    currentPageIndex = value;
  }

  void previousPage() {
    if (pageHistory.isEmpty) return;
    int page = pageHistory.removeLast();
    if (pageHistory.isEmpty) return;
    page = pageHistory.removeLast();
    navigateToPage(page);
  }
}
