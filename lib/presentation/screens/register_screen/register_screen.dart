import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/register_screen/register_controller.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:folldy_student/utils/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = RegisterController();
    registerController.phoneController.text = phone;
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
                validator: (val) => validatePhone(phone: val),
              ),
              TextFormField(
                autofillHints: const [AutofillHints.name],
                keyboardType: TextInputType.name,
                controller: registerController.usernameController,
                decoration: const InputDecoration(label: Text("Username")),
                validator: (val) {
                  return val!.isEmpty ? "Username is requred" : null;
                },
              ),
              TextFormField(
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  controller: registerController.emailController,
                  decoration: const InputDecoration(label: Text("Email")),
                  validator: emailValidator),
              defaultSpacer,
              ElevatedButton(
                  onPressed: registerController.register,
                  child: const Text("Register")),
            ],
          ),
        ),
      ),
    );
  }

  String? emailValidator(String? value) {
    return value!.isEmpty
        ? "Email is required"
        : !value.isEmail
            ? "Please enter a valid email"
            : null;
  }
}
