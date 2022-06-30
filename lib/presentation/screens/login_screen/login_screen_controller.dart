import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/otp_validation_screen/otp_validation_screen.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/check_registered_user.dart';

import '../../../utils/snackbar_utils.dart';

class LoginScreenController extends ChangeNotifier {
  CheckRegisteredUser checkRegisteredUser = CheckRegisteredUser(Get.find());

  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  bool buttonLoading = false;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  checkPhoneRegistered() async {
    if (!validate()) return;
    final response = await checkRegisteredUser(
        CheckRegisteredUserParams(phone: phoneController.text));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 1) {
        Get.toNamed(AppRoute.otpValidationScreen,
            arguments: OTPvalidationParams(otPvalidationType: OTPvalidationType.login, phoneNumber: phoneController.text));
      } else if (r["status"] == 0) {
        Get.toNamed(AppRoute.otpValidationScreen);
        showErrorMessage(r["message"]);
      } else {
        showErrorMessage(r["message"]);
      }
    });
  }
}
