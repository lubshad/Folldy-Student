import 'package:basic_template/basic_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/otp_validation_screen/otp_validation_screen.dart';

class OTPvalidationController extends ChangeNotifier {
  final firebaseAuthInstance = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: 'OTP_form_key');

  OTPvalidationType type = OTPvalidationType.login;

  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  bool buttonLoading = true;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  String? verificationID;

  sendOtp() async {
    makeButtonLoading();
    await firebaseAuthInstance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {
        makeButtonNotLoading();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          logger.info('The provided phone number is not valid.');
        }
        makeButtonNotLoading();
      },
      timeout: const Duration(minutes: 2),
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        logger.info(verificationId);
        makeButtonNotLoading();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp() async {
    makeButtonLoading();
    logger.info(verificationID);
    logger.info(otpController.text);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otpController.text);
    try {
      await firebaseAuthInstance.signInWithCredential(credential);
      if (type == OTPvalidationType.login) {
        Get.back();
      } else {
        Get.toNamed(AppRoute.registerScreen, arguments: phoneController.text);
      }

      makeButtonNotLoading();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      makeButtonNotLoading();
    }
  }
}
