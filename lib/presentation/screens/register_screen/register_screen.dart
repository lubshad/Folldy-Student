import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/register_screen/register_controller.dart';
import 'package:folldy_student/utils/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = RegisterController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: registerController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofillHints: const [AutofillHints.telephoneNumberDevice],
                controller: registerController.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(label: Text("Phone")),
              ),
              TextFormField(
                autofillHints: const [AutofillHints.name],
                keyboardType: TextInputType.name,
                controller: registerController.usernameController,
                decoration: const InputDecoration(label: Text("Username")),
              ),
              TextFormField(
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                controller: registerController.emailController,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              defaultSpacer,
              ElevatedButton(onPressed: registerController.register, child: const Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
