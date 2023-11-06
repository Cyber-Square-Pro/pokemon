import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mediumBlue,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hSpace(200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pokeball.png',
                  width: 50,
                ),
                wSpace(10),
                Text(
                  'Login',
                  style: pageTitle,
                ),
              ],
            ),
            // Form
            hSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      prefixIcon: Icons.person,
                      labelText: 'Username',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      labelText: 'Password',
                    ),
                    hSpace(25),
                    PrimaryElevatedButton(
                      label: 'Log In',
                      onPressed: () {},
                    ),
                    hSpace(15),
                    CustomTextButton(
                      onPressed: () {},
                      label: 'Forgot Password?',
                    ),
                  ],
                ),
              ),
            ),
            //Ashr
            const Spacer(),
            hSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/ash_blue.png',
                  width: 220,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
