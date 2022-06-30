import 'dart:convert';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/get_student_dashboard.dart';

import '../../../data/core/auth_controller.dart';
import '../../../utils/snackbar_utils.dart';

class DashboardController extends ChangeNotifier {
  final box = GetStorage();
  DashboardController() {
    final data = box.read("dashboard_details") ??
        jsonEncode({"status": 1, "subjects": [], "recently_viewed": []});
    dashboardDetails = jsonDecode(data);
    box.listenKey("dashboard_details", (value) {
      dashboardDetails = jsonDecode(value);
      notifyListeners();
    });
  }
  GetStudentDashboard getStudentDashboard = GetStudentDashboard(Get.find());
  AppError? appError;
  bool isLoading = false;

  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    appError = null;
    makeNotLoading();
    getData();
  }

  Map<String, dynamic>? dashboardDetails;

  getData() async {
    final response = await getStudentDashboard(GetStudentDashboardParams(
        studentId: Get.find<AuthController>().student!.id));
    response.fold((l) => l.handleError(), (r) => handleResponse(r));
    makeNotLoading();
  }

  handleResponse(Map<String, dynamic> r) {
    if (r["status"] == 1) {
      box.write("dashboard_details", jsonEncode(r));
    } else {
      showErrorMessage(r["message"]);
    }
  }
}
