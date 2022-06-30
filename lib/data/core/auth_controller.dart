import 'package:basic_template/basic_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/data/models/student.dart';
import 'package:folldy_utils/domain/usecase/check_registered_user.dart';
import 'package:folldy_utils/domain/usecase/student_login.dart';

import '../../utils/snackbar_utils.dart';

class AuthController extends ChangeNotifier {
  StudentLogin studentLogin = StudentLogin(Get.find());

  CheckRegisteredUser checkRegisteredUser = CheckRegisteredUser(Get.find());

  Student? get student => _student;
  Student? _student;
  AuthController() {
    firebaseAuthInstance.userChanges().listen((newUser) {
      // user = newUser;
      if (newUser != null) {
        login(newUser.phoneNumber!.substring(3), newUser.uid);
      } else {
        _student = null;
        notifyListeners();
      }
    });
  }

  // User? user;
  final firebaseAuthInstance = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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

  String? verificationID;

  void login(String phoneNumber, uuid) async {
    final response =
        await studentLogin(StudentLoginParams(phone: phoneNumber, uuid: uuid));
    response.fold((l) {
      l.handleError();
    }, (r) => validateLogin(r));
  }

  

  validateLogin(Map<String, dynamic> r) async {
    if (r["status"] == 0) {
      showErrorMessage(r["message"]);
      await firebaseAuthInstance.signOut();
    } else {
      Student student = Student.fromJson(r["data"]);
      loginStudent(student);
    }
  }

  

  

  void loginStudent(Student student) {
    _student = student;
    makeButtonNotLoading();
  }

  logout() async {
    await firebaseAuthInstance.signOut();
  }
}
