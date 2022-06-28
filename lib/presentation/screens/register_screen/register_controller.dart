import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_student/utils/snackbar_utils.dart';
import 'package:folldy_utils/domain/usecase/register_student.dart';

class RegisterController extends ChangeNotifier {
  RegisterStudent registerStudent = RegisterStudent(Get.find());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool buttonLoading = false;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'register_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  void register() async {
    if (!validate()) return;
    final response = await registerStudent(RegisterStudentParams(
        phone: phoneController.text,
        email: emailController.text,
        username: usernameController.text));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 0) {
        showErrorMessage(r["message"]);
      }
    });
  }
}
