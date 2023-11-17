import 'package:app/shared/repositories/user_repo.dart';
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
  final _formKey = GlobalKey<FormState>();
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
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Email',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _passwordcontroller,
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
                          // UserRepo().dioTest();
                          // if (await UserRepo()
                          //     .userLogin(_emailcontroller.text, _passwordcontroller.text)) {
                          //   Navigator.pushNamed(
                          //     context,
                          //     '/home',
                          //     arguments: ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Login Success!')),
                          //     ),
                          //   );
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('Invalid email or password!'),
                          //     ),
                          //   );
                          // }
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid credentials'),
                              backgroundColor: Colors.red,
                            ));
                          }
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
