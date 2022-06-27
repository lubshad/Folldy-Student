import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
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

  

  void register() {
  }
}
