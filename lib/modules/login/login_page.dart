import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

// Add this method in AuthService to get the Dio instance.
  }

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  // Auth
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    AuthService().apiTest();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg/login_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
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
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter a valid username';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Username',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter a valid password';
                        } else {
                          return null;
                        }
                      },
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      labelText: 'Password',
                    ),
                    hSpace(15),
                    CustomTextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/verifyEmail');
                      },
                      label: 'Forgot Password? Click Here',
                    ),
                    hSpace(15),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ]),
                      child: CustomElevatedButton(
                        label: 'Log In',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              showLoadingSpinnerModal(context, 'Logging In');
                              if (await authService.login(
                                _usernameController.text.trim(),
                                _passwordController.text.trim(),
                              )) {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                  arguments: [
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        CustomSnackbars.successSnackbar('Welcome to Pokedex')),
                                  ],
                                );
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    CustomSnackbars.errorSnackbar(
                                        'Login Failed: Please check your credentials'));
                              }
                              // Navigate to secured screen on successful login
                            } catch (error) {
                              // Handle login error
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbars.errorSnackbar(
                                      'Login Failed: Please check your credentials'));
                              print('Login Error: $error');
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(CustomSnackbars.errorSnackbar('Invalid submission!'));
                          }
                        },
                      ),
                    ),
                    hSpace(20),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      label: 'Dont have an account? Sign Up.',
                    ),
                    hSpace(20),
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
