import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg/login_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hSpace(120),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    'assets/images/pokemon_logo.png',
                  ),
                ),
              ),
            ),
            hSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/pokeball.png',
                  width: 40,
                ),
                wSpace(5),
                const Text(
                  'Log In',
                  style: pageTitle,
                ),
                hSpace(20),
              ],
            ),
            // Form
            hSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Form(
                child: Column(
                  children: [
                     CustomTextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Username',
                    ),
                    hSpace(20),
                     CustomTextFormField(
                       controller: _passwordcontroller,
                       keyboardType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      labelText: 'Password',
                    ),
                    hSpace(20),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ]),
                      child: CustomElevatedButton(
                        label: 'Log In',
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      label: 'Dont have an account? Sign Up.',
                    ),
                    hSpace(20),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/verifyEmail');
                      },
                      label: 'Forgot Password',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
