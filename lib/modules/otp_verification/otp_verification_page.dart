import 'dart:math';

import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/otp_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late SignupProvider signupProv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer logic
    final signupProv = Provider.of<SignupProvider>(context, listen: false);
  }

  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupProv = Provider.of<SignupProvider>(context, listen: false);
    final _otpProvider = Provider.of<OtpProvider>(context, listen: false);
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
            hSpace(150),
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
            hSpace(40),
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
                  'Verify with OTP',
                  style: pageTitleWithShadow,
                ),
              ],
            ),
            //Form
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    hSpace(5),
                    Text(
                      'Enter the 6 Digit OTP that has been sent to your email.',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: pageSubtitle,
                    ),
                    hSpace(20),

                    // otp field
                    CustomOtpField(
                      controller: _otpController,
                      validator: (value) {
                        if (value != null || value != '') {
                          if (value!.length < 6) return 'Please enter a valid OTP';
                        }
                        return null;
                      },
                    ),
                    //
                    hSpace(15),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      label: 'Resend OTP',
                    ),
                    hSpace(15),
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
                        label: 'Verify',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print(_otpController.text);
                            final data = signupProv.getSignupData;
                            final email =
                                (data['email'] != null) ? data['email'] : _otpProvider.email;
                            if (await OtpService().verifyEmail(
                              context,
                              email,
                              int.parse(_otpController.text),
                            )) {
                              print('OTP Verified');
                              if (_otpProvider.getIntent() == OtpIntent.SIGN_UP) {
                                if (await AuthService().signup(
                                  username: data['username'],
                                  email: data['email'],
                                  phoneNumber: int.parse(data['phone_number']),
                                  password: data['password'],
                                )) {
                                  _otpController.clear();
                                  Navigator.pushNamed(
                                    context,
                                    '/login',
                                    arguments: [
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.success(
                                            'Succesfully Created Account, Login to continue'),
                                      ),
                                    ],
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackbars.error('Failed to create Account'),
                                  );
                                }
                              } else if (_otpProvider.getIntent() == OtpIntent.RESET_PASS) {
                                _otpProvider.setIntent(OtpIntent.RESET_PASS);
                                Navigator.pushReplacementNamed(context, '/resetPass');
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(MySnackbars.error('Failed to verify OTP'));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(MySnackbars.error('Eeror during OTP verification'));
                          }
                        },
                      ),
                    ),
                    hSpace(15),
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
