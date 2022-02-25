import 'package:flutter/cupertino.dart';
import 'package:folldy_student/data/models/lean_screen_response.dart';
import 'package:folldy_student/domain/entities/app_error.dart';
import 'package:folldy_student/domain/entities/no_params.dart';
import 'package:folldy_student/domain/usecase/get_learn_screen_data.dart';
import 'package:get/get.dart';

class LearnScreenController extends ChangeNotifier {
  GetLearnScreenData getLearnScreenData = GetLearnScreenData(Get.find());

  LearnScreenResponse? learnScreenResponse;

  AppError? appError;
  bool isLoading = true;
  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    makeLoading();
    await Future.delayed(const Duration(seconds: 2));
    makeNotLoading();
  }

  getData() async {
    final result = await getLearnScreenData(NoParams());
    result.fold((l) => l.handleError(), (r) {
      if (r.status == 1) {
        setData(r);
      }
    });
    makeNotLoading();
  }

  void setData(LearnScreenResponse r) {
    learnScreenResponse = r;
  }
}
