import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/add_teacher_to_batch.dart';
import 'package:folldy_utils/domain/usecase/assign_subject_to_faculty.dart';
import 'package:folldy_utils/domain/usecase/change_live_semester.dart';
import 'package:folldy_utils/domain/usecase/get_batch_details.dart';

import '../../../utils/snackbar_utils.dart';
import '../../../data/core/auth_controller.dart';
import 'components/teacher_selection_bottom_sheet.dart';

class BatchDetailsController extends ChangeNotifier {
  Map<String, dynamic>? batch;
  GetBatchDetails getBatchDetails = GetBatchDetails(Get.find());
  AssignSubjectToFaculty assignSubjectToFaculty =
      AssignSubjectToFaculty(Get.find());
  ChangeLiveSemester changeLiveSemester = ChangeLiveSemester(Get.find());
  AddTeachersToBatch addTeachersToBatch = AddTeachersToBatch(Get.find());
  AuthController authController = Get.find();

  AppError? appError;
  bool isLoading = true;

  bool get isAdmin =>
      availableTeachers
          .singleWhere((element) => element["isAdmin"] == true)["id"] ==
      authController.student?.id;

  // List<Map<String, dynamic>> get semesters {
  //   return batchDetails == null ? [] : batchDetails!["data"]["semesters"];
  // }

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
    makeLoading();
    getData();
  }

  Map<String, dynamic>? batchDetails;

  getData() async {
    final response = await getBatchDetails(GetBatchDetailsParams(
        batchId: batch!["id"], facultyId: authController.student!.id));
    response.fold((l) => appError = l, (r) => handleResponse(r));
    makeNotLoading();
  }

  handleResponse(Map<String, dynamic> r) {
    List subjects = r["data"]["subjects"];
    int liveSemester = r["data"]["liveSemester"];
    List<Map<String, dynamic>> semesters = [];
    for (Map<String, dynamic> subject in subjects) {
      int semester = subject["semester"];
      int index = semesters.indexWhere((e) => e["semester"] == semester);
      if (index == -1) {
        semesters.add({
          "live": semester == liveSemester,
          "semester": semester,
          "subjects": [subject]
        });
      } else {
        semesters[index]["subjects"].add(subject);
      }
    }
    // print(semesters);
    r["data"]["semesters"] = semesters;
    batchDetails = r;
  }

  void addSubjectToDashboard(subject) async {
    final response = await assignSubjectToFaculty(AssignSubjectTOFacultyParams(
        batchId: batch!["id"],
        facultyId: authController.student!.id,
        subjectId: subject["id"]));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 0) {
        showErrorMessage(r["message"]);
      } else {
        getData();
      }
    });
  }

  makeSemesterLive(semester) async {
    final response = await changeLiveSemester(ChangeLiveSemesterParams(
        semester: semester["semester"], batchId: batch!["id"]));
    response.fold((l) => l.handleError(), (r) => getData());
  }

  List get availableTeachers =>
      batchDetails?["data"]["availableTeachers"] ?? [];

  void showTeacherList() {
    Get.bottomSheet(TeacherSelectionBottomSheet(
      batchDetailsController: this,
    ));
  }

  addSelectedTeachers() async {
    Get.back();
    List<int> teacherIds = availableTeachers
        .where((element) => element["selected"] == true)
        .map((e) => e["id"] as int)
        .toList();
    final response = await addTeachersToBatch(AddTeachersToBatchParams(
        batchId: batch!["id"], teacherIds: teacherIds));

    response.fold((l) => l.handleError(), (r) => getData());
  }
}
