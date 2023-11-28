import 'package:app/shared/providers/password_obscure_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.backgroundPlainImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        AppConstants.pokemonLogo,
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
                    horizontal: 30,
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
                        Consumer<ObscureProvider>(
                          builder: (context, provider, _) => Column(
                            children: [
                              CustomTextFormField(
                                controller: _passwordcontroller,
                                isPassword: provider.obscureSignupPassword,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Enter a valid password';
                                  } else {
                                    return null;
                                  }
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureSignupPassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                  ),
                                  onPressed: () {
                                    provider.toggleSignupPasswordHidden();
                                  },
                                ),
                                prefixIcon: Icons.lock_outline,
                                labelText: 'Enter Password',
                              ),
                              hSpace(20),
                              CustomTextFormField(
                                controller: _confirmpasswordcontroller,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Enter a valid name';
                                  } else if (value != _passwordcontroller.text) {
                                    return 'Passwords do not match';
                                  } else {
                                    return null;
                                  }
                                },
                                isPassword: provider.obscureSignupConfirmPassword,
                                prefixIcon: Icons.lock,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureSignupConfirmPassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                  ),
                                  onPressed: () {
                                    provider.toggleSignupPasswordConfirmHidden();
                                  },
                                ),
                                labelText: 'Confirm Password',
                              ),
                            ],
                          ),
                        ),
                        hSpace(20),
                        Container(
                          width: 120,
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
                                showLoadingSpinnerModal(context, 'Signing up...');
                                final signupProvider =
                                    Provider.of<SignupProvider>(context, listen: false);

                                signupProvider.setSignupData({
                                  'username': _namecontroller.text.trim(),
                                  'email': _emailaddresscontroller.text.trim(),
                                  'phone_number': _phonenumbercontroller.text.trim(),
                                  'password': _passwordcontroller.text.trim(),
                                });

                                if (await OtpService()
                                    .sendOTP(signupProvider.getSignupData['email'])) {
                                  _namecontroller.clear();
                                  _emailaddresscontroller.clear();
                                  _phonenumbercontroller.clear();
                                  _passwordcontroller.clear();
                                  _confirmpasswordcontroller.clear();

                                  if (context.mounted) {
                                    Navigator.popAndPushNamed(context, '/otp');
                                    Provider.of<ObscureProvider>(context, listen: false)
                                        .resetSettings();
                                  }
                                } else {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(MySnackbars.error('Failed to send OTP'));
                                    signupProvider.clearSignupData();
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(MySnackbars.error('Invalid Submission!'));
                              }
                            },
                          ),
                        ),
                        hSpace(15),
                        CustomTextButton(
                          onPressed: () {
                            Provider.of<ObscureProvider>(context, listen: false).resetSettings();
                            Navigator.pushNamed(context, '/login');
                          },
                          label: 'Already have an account? Login Here.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
