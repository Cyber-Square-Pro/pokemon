import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newpasswordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  'Reset Password',
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
                    hSpace(20),
                    Text(
                      'Please create a new password for your account.',
                      style: pageSubtitle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    hSpace(10),
                    CustomTextFormField(
                      controller: _newpasswordcontroller,
                      isPassword: true,
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock_reset,
                      labelText: 'New Password',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _confirmpasswordcontroller,
                      isPassword: true,
                      validator: (value) {
                        if (value == '' || value != _confirmpasswordcontroller.text) {
                          return 'Confirmed password does not match!!!';
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock_reset,
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
                        label: 'Reset',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final email = _otpProvider.email;
                            if (await OtpService()
                                .resetPassword(email, _newpasswordcontroller.text)) {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(MySnackbars.error('Failed To Reset Password'));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                MySnackbars.error('Passwords do not match / Invalid passwords'));
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
