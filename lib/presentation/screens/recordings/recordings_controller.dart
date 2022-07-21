import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_student/utils/snackbar_utils.dart';
import 'package:folldy_utils/domain/usecase/delete_recorded_audio.dart';
import 'package:folldy_utils/domain/usecase/get_all_recoded_presentations.dart';

import '../../../data/core/auth_controller.dart';

class RecordingsController extends ChangeNotifier {
  GetAllRecordedPresentations getAllRecordedPresentations =
      GetAllRecordedPresentations(Get.find());

  DeleteRecordedAudio deleteRecordedAudio = DeleteRecordedAudio(Get.find());

  List get recordings =>
      facultyRecordings == null ? [] : facultyRecordings!["data"];

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

  Map<String, dynamic>? facultyRecordings;

  getData() async {
    final response = await getAllRecordedPresentations(
        GetRecordedPresentationsArguments(
            facultyId: Get.find<AuthController>().student!.id.toString()));
    response.fold((l) => l.handleError(), (r) => handleResponse(r));
    makeNotLoading();
  }

  handleResponse(Map<String, dynamic> r) {
    facultyRecordings = r;
    notifyListeners();
  }

  handlePopupMenu(PopupOptions e, Map<String, dynamic> presentation) {
    switch (e) {
      case PopupOptions.delete:
        deletePresentationAudio(presentation);
        break;
      case PopupOptions.edit:
        break;
    }
  }

  void deletePresentationAudio(Map<String, dynamic> presentation) async {
    final response = await deleteRecordedAudio(
        DeleteRecordedAudioParams(audioId: presentation["audio"][0]["id"]));
    response.fold((l) => l.handleError(), (r) => getData());
  }
}
