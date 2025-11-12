import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/core/util/assets.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/providers/user_provider.dart';
import 'package:betweeener_app/views_features/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main_app_view.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/google_button_widget.dart';
import '../widgets/primary_outlined_button_widget.dart';
import '../widgets/secondary_button_widget.dart';

class LoginView extends StatelessWidget {
  static String id = '/loginView';

  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void submitLogin() async {
      if (_formKey.currentState!.validate()) {
        final body = {
          'email': emailController.text,
          'password': passwordController.text,
        };

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.login(body);

        final userResponse = userProvider.user;

        if (userResponse.status == Status.COMPLETED &&
            userResponse.data != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('user', userToJson(userResponse.data!));

          userProvider.setUser(userResponse.data!);

          Navigator.pushReplacementNamed(context, MainAppView.id);
        } else if (userResponse.status == Status.ERROR) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userResponse.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Hero(
                      tag: 'authImage',
                      child: SvgPicture.asset(AssetsData.authImage),
                    ),
                  ),
                  const Spacer(),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    autofillHints: const [AutofillHints.password],
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SecondaryButtonWidget(onTap: submitLogin, text: 'LOGIN'),
                  const SizedBox(height: 24),
                  PrimaryOutlinedButtonWidget(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterView.id);
                    },
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
