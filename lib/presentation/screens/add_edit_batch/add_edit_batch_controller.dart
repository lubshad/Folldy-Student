import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/data/models/course_list_response.dart';
import 'package:folldy_utils/domain/usecase/add_edit_batch.dart';
import 'package:folldy_utils/domain/usecase/get_all_courses.dart';

import '../login_screen/auth_controller.dart';

class AddEditBatchController extends ChangeNotifier {
  AddEditBatchController(this.refresh);
  GetAllCourses getAllCourses = GetAllCourses(Get.find());
  AddEditBatch addEditBatch = AddEditBatch(Get.find());
  AuthController authController = Get.find();

  TextEditingController batchNameController = TextEditingController();

  List<Course> courses = [];
  final VoidCallback refresh;

  AppError? appError;
  bool isLoading = true;

  List<DropdownMenuItem<Course>> get courseDropdownItems => courses
      .map((e) => DropdownMenuItem<Course>(
          value: e,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: e.name,
                style: Theme.of(Get.context!).textTheme.bodyText1),
            TextSpan(
                text: " - ${e.university.name}",
                style: Theme.of(Get.context!).textTheme.caption)
          ]))))
      .toList();

  List<DropdownMenuItem<DateTimeRange>> get batchItems {
    if (selectedCourse == null) {
      return [];
    }
    int courseDurationInYears = selectedCourse!.semesters % 2 == 0
        ? selectedCourse!.semesters ~/ 2
        : (selectedCourse!.semesters ~/ 2) + 1;
    int currentYear = DateTime.now().year;
    List<DateTimeRange> batchDurations = [];
    for (int i = 0; i < courseDurationInYears + 1; i++) {
      DateTime startYear = DateTime(currentYear + i - courseDurationInYears);
      DateTime endYear = DateTime(currentYear + i);
      batchDurations.add(DateTimeRange(start: startYear, end: endYear));
    }
    return batchDurations
        .map((e) => DropdownMenuItem<DateTimeRange>(
            value: e, child: Text("${e.start.year} - ${e.end.year}")))
        .toList();
  }

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
    getCourses();
  }

  getCourses() async {
    final response = await getAllCourses(CourseListingParams());
    response.fold((l) => l.handleError(), (r) => courses = r);
    makeNotLoading();
  }

  Course? selectedCourse;

  void selectCourse(Course? value) {
    selectedCourse = value;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'batch_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  void addOrEditBatch() async {
    if (!validate()) return;
    final response = await addEditBatch(AddEditBatchParams(
      facultyId: authController.faculty!.id,
      institutionId: authController.faculty!.institution,
      duration: batchDuration!,
      batchName: batchNameController.text,
      courseId: selectedCourse!.id!,
    ));
    response.fold((l) => l.handleError(), (r) {
      refresh();
      Get.back();
    });
  }

  DateTimeRange? batchDuration;
  void selectBatch(DateTimeRange? value) {
    batchDuration = value;
    notifyListeners();
  }
}
