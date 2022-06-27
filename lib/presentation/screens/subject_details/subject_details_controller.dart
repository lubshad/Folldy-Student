import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/add_presentation_to_wall.dart';
import 'package:folldy_utils/domain/usecase/get_subject_details.dart';

class SubjectDetailsController extends ChangeNotifier {
  GetSubjectDetails getSubjectDetails = GetSubjectDetails(Get.find());
  AddPresentationToWall addPresentationToWall =
      AddPresentationToWall(Get.find());

  Map<String, dynamic>? subject;
  AppError? appError;
  bool isLoading = true;

  List get modules => subjectDetails == null ? [] : subjectDetails!["modules"];

  int? get presentationOnWall =>
      subjectDetails?["subject"]["presentationOnWall"];

  makeLoading() {
    appError = null;
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

  Map<String, dynamic>? subjectDetails;

  getData() async {
    final response = await getSubjectDetails(
        GetSubjectDetailsParams(subjectId: subject!["id"]));
    response.fold((l) => appError = l, (r) => handleResponse(r));
    makeNotLoading();
  }

  handleResponse(Map<String, dynamic> r) {
    List<Map<String, dynamic>> moduleViseChapters = [];
    for (Map<String, dynamic> chapter in r["subject"]["chapters"]) {
      Map<String, dynamic>? addedModule = moduleViseChapters.firstWhereOrNull(
          (element) => element["module"] == chapter["module"]);

      if (addedModule == null) {
        Map<String, dynamic> moduleViseChapter = {
          "module": chapter["module"],
          "chapters": [chapter],
        };
        moduleViseChapters.add(moduleViseChapter);
      } else {
        addedModule["chapters"].add(chapter);
      }
    }
    r["modules"] = moduleViseChapters;
    subjectDetails = r;
    notifyListeners();
  }

  presentationToWall(int presentationId) async {
    final response = await addPresentationToWall(AddPresentationToWallParams(
        presentationId: presentationId, subjectId: subject!["id"]));
    response.fold((l) => l.handleError(), (r) {
      getData();
      Get.find<DashboardController>().getData();
    });
  }
}
