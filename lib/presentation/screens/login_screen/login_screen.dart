import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_student/presentation/screens/home_screen/home_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../utils/constants.dart';
import '../../../utils/validators.dart';
import 'auth_controller.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return AnimatedBuilder(
        animation: authController,
        builder: (context, child) => authController.student == null
            ? const LoginScreen()
            : const HomeScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CodeAutoFill {
  AuthController authController = Get.find();
  String? otpCode;

  @override
  void codeUpdated() {
    logger.info(code!);
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: authController.formKey,
          child: AnimatedBuilder(
              animation: authController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (authController.verificationID == null)
                      TextFormField(
                        controller: authController.phoneController,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        decoration: const InputDecoration(
                          label: Text("Phone"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (phone) => validatePhone(phone: phone),
                      ),
                    if (authController.verificationID != null)
                      PinFieldAutoFill(
                        controller: authController.otpController,
                        decoration: UnderlineDecoration(
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          colorBuilder:
                              FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        ),
                        currentCode: otpCode,
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          if (code!.length == 6) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                    defaultSpacer,
                    ElevatedButton(
                        onPressed: authController.buttonLoading
                            ? null
                            : authController.verificationID == null
                                ? authController.checkPhoneRegistered
                                : authController.verifyOtp,
                        // onPressed: () => authController.login(null),
                        child: authController.buttonLoading
                            ? const SizedBox(
                                width: 100,
                                height: defaultPaddingLarge,
                                child: DefaultLoadingWidget(
                                  color: Colors.white,
                                ))
                            : Text(authController.verificationID == null
                                ? "SENT OTP"
                                : "Verify OTP"))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
