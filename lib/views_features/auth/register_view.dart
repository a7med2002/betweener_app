import 'package:betweeener_app/controllers/auth_controller.dart';
import 'package:betweeener_app/core/util/assets.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/google_button_widget.dart';
import '../widgets/secondary_button_widget.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submitRigster() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      };
      register(body)
          .then((user) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, LoginView.id);
            }
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: Hero(
                      tag: 'authImage',
                      child: SvgPicture.asset(AssetsData.authImage),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    controller: nameController,
                    hint: 'John Doe',
                    label: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name can't be empty";
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "email can't be empty";
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "password can't be empty";
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  SecondaryButtonWidget(
                    onTap: () => submitRigster(),
                    text: 'REGISTER',
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
