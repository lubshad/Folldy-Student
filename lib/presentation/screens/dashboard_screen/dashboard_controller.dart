import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/get_faculty_dashboard.dart';

import '../login_screen/auth_controller.dart';

class DashboardController extends ChangeNotifier {
  GetFacultyDashboard getFacultyDashboard = GetFacultyDashboard(Get.find());
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
    appError = null;
    makeNotLoading();
    getData();
  }

  Map<String, dynamic>? dashboardDetails;

  getData() async {
    final response = await getFacultyDashboard(GetFacultyDashboardParams(
        facultyId: Get.find<AuthController>().student!.id));
    response.fold((l) => l.handleError(), (r) => handleResponse(r));
    makeNotLoading();
  }

  handleResponse(Map<String, dynamic> r) {
    dashboardDetails = r;
    notifyListeners();
  }
}
