import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

import 'package:folldy_student/presentation/screens/otp_validation_screen/otp_validation_controller.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:sms_autofill/sms_autofill.dart';

enum OTPvalidationType {
  login,
  registration,
}

class OTPvalidationParams {
  final OTPvalidationType otPvalidationType;
  final String phoneNumber;

  OTPvalidationParams(
      {required this.otPvalidationType, required this.phoneNumber});
}

class OtpValidationScreen extends StatefulWidget {
  const OtpValidationScreen({Key? key, required this.otPvalidationParams})
      : super(key: key);

  final OTPvalidationParams otPvalidationParams;

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen>
    with CodeAutoFill {
  OTPvalidationController otpValidationController = OTPvalidationController();
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
    otpValidationController.phoneController.text =
        widget.otPvalidationParams.phoneNumber;
    otpValidationController.type = widget.otPvalidationParams.otPvalidationType;
    otpValidationController.sendOtp();
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Validation"),
      ),
      body: Form(
        key: otpValidationController.formKey,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PinFieldAutoFill(
                controller: otpValidationController.otpController,
                decoration: UnderlineDecoration(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
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
              ElevatedButton(
                  onPressed: otpValidationController.verifyOtp, child: const Text("Validate OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
