
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_student/presentation/screens/login_screen/login_screen_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/validators.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginScreenController loginScreenController = LoginScreenController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: loginScreenController.formKey,
          child: AnimatedBuilder(
              animation: loginScreenController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: loginScreenController.phoneController,
                      keyboardType: TextInputType.phone,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      decoration: const InputDecoration(
                        label: Text("Phone"),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (phone) => validatePhone(phone: phone),
                    ),
                    defaultSpacer,
                    ElevatedButton(
                        onPressed: loginScreenController.checkPhoneRegistered, child: const Text("SENT OTP"))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
