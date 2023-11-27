import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _otpProvider = Provider.of<OtpProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.backgroundImage),
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    AppConstants.pokemonLogo,
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
                  'Verify via Email',
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
                      'Please enter your email, An OTP Number will be sent to this email shortly.',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: pageSubtitle,
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'invalid email';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.email,
                      labelText: 'Enter your email',
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
                        label: 'Continue',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showLoadingSpinnerModal(context, 'Loading...');
                            _otpProvider.setIntent(OtpIntent.RESET_PASS);
                            if (await OtpService().sendOTP(_emailController.text.trim())) {
                              _otpProvider.setEmail(_emailController.text.trim());
                              Navigator.pop(context);
                              Navigator.popAndPushNamed(
                                context,
                                '/otp',
                                arguments: [
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackbars.success('OTP Has been sent succesfully'),
                                  ),
                                ],
                              );
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                MySnackbars.error('Failed to send OTP'),
                              );
                            }
                          } else {
                            // Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              MySnackbars.error(
                                  'Invalid Submission, please check your email again.'),
                            );
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
