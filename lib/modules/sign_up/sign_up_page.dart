import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _phonenumbercontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _emailaddresscontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hSpace(100),
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
                Text(
                  'Create An Account',
                  style: pageTitleWithShadow,
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
                      controller: _namecontroller,
                      validator: (value) {
                        if (value == '') {
                          return 'Enter a valid name';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Username',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _phonenumbercontroller,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == '') {
                          return 'Enter a valid phone number';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.phone_android,
                      labelText: 'Phone Number',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _emailaddresscontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.email,
                      labelText: 'Email Address',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _passwordcontroller,
                      isPassword: true,
                      validator: (value) {
                        if (value == '') {
                          return 'Enter a valid password';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.lock_outline,
                      labelText: 'Enter Password',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _confirmpasswordcontroller,
                      isPassword: true,
                      validator: (value) {
                        if (value == '') {
                          return 'Enter a valid name';
                        } else if (value != _passwordcontroller.text) {
                          return 'Passwords do not match';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.lock,
                      labelText: 'Confirm Password',
                    ),
                    hSpace(20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(0.25),
                          )
                        ],
                      ),
                      child: CustomElevatedButton(
                        label: 'Sign Up',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final signupData = Provider.of<SignupProvider>(context, listen: false);

                            signupData.setSignupData({
                              'username': _namecontroller.text.trim(),
                              'email': _emailaddresscontroller.text.trim(),
                              'phone_number': _phonenumbercontroller.text.trim(),
                              'password': _passwordcontroller.text.trim(),
                            });

                            if (await OtpService().sendOTP(signupData.getSignupData['email'])) {
                              _namecontroller.clear();
                              _emailaddresscontroller.clear();
                              _phonenumbercontroller.clear();
                              _passwordcontroller.clear();
                              _confirmpasswordcontroller.clear();

                              Navigator.pushNamed(context, '/otp');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbars.errorSnackbar('Failed to send OTP'));
                              signupData.clearSignupData();
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(CustomSnackbars.errorSnackbar('Invalid Submission!'));
                          }
                        },
                      ),
                    ),
                    hSpace(15),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      label: 'Already have an account? Login Here.',
                    ),
                    hSpace(10),
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
