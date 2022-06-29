// import 'package:basic_template/basic_template.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:folldy_utils/domain/usecase/list_institution_batches.dart';

// import '../login_screen/auth_controller.dart';

// class BatchListingController extends ChangeNotifier {
//   ListInstitutionBatches listInstitutionBatches =
//       ListInstitutionBatches(Get.find());
//   AuthController authController = Get.find<AuthController>();

//   List batches = [];

//   AppError? appError;
//   bool isLoading = true;
//   makeLoading() {
//     isLoading = true;
//     notifyListeners();
//   }

//   makeNotLoading() {
//     isLoading = false;
//     notifyListeners();
//   }

//   retry() async {
//     appError = null;
//     makeLoading();
//     getAllBatches();
//   }

//   getAllBatches() async {
//     final response = await listInstitutionBatches(InstitutionBatchListingParams(
//         institutionId: authController.student!.institution!,
//         facultyId: authController.student!.id));
//     response.fold((l) => appError = l, (r) => handleResponse(r));
//     makeNotLoading();
//   }

//   handleResponse(Map<String, dynamic> r) {
//     if (r["status"] == 1) {
//       batches = r["data"];
//     } else {
//       appError = const AppError(AppErrorType.api);
//     }
//   }
// }
