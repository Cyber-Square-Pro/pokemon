import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newpasswordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  

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
                        onPressed: () {
                          Navigator.pushNamed(context, '/otp');
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
