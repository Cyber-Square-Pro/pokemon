import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/signup_provider.dart';
import 'package:app/shared/providers/timer_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/ui/widgets/timer_text.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
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
  }

  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupProv = Provider.of<SignupProvider>(context, listen: false);
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    TimerProvider();

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
                    hSpace(25),
                    StreamBuilder<int>(
                      stream: context.read<TimerProvider>().timerStream,
                      initialData: context.read<TimerProvider>().initialTimeInSeconds,
                      builder: (context, snapshot) {
                        int remainingSeconds = snapshot.data!;
                        return !(remainingSeconds > 0)
                            ? CustomTextButton(
                                onPressed: () async {
                                  showLoadingSpinnerModal(context, 'Sending OTP...');
                                  if (await OtpService().sendOTP(otpProvider.email)) {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.success('A new OTP has been sent'),
                                      );
                                      context.read<TimerProvider>().restartTimer();
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.error('Failed to send OTP'),
                                      );
                                    }
                                  }
                                },
                                label: 'Resend OTP',
                              )
                            : timerText(
                                _formatDuration(Duration(seconds: remainingSeconds)),
                              );
                      },
                    ),
                    //

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
                            showLoadingSpinnerModal(context, 'Verifying...');
                            final data = signupProv.getSignupData;
                            final email =
                                (data['email'] != null) ? data['email'] : otpProvider.email;
                            if (await OtpService().verifyEmail(
                              context,
                              email,
                              int.parse(_otpController.text),
                            )) {
                              print('OTP Verified');
                              if (otpProvider.getIntent() == OtpIntent.SIGN_UP) {
                                if (await AuthService().signup(
                                  username: data['username'],
                                  email: data['email'],
                                  phoneNumber: int.parse(data['phone_number']),
                                  password: data['password'],
                                )) {
                                  _otpController.clear();
                                  (context.mounted)
                                      ? Navigator.popAndPushNamed(
                                          context,
                                          '/login',
                                          arguments: [
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              MySnackbars.success(
                                                'Succesfully Created Account, Login to continue',
                                              ),
                                            ),
                                          ],
                                        )
                                      : null;
                                } else {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      MySnackbars.error('Failed to create Account'),
                                    );
                                  }
                                } // ELSE BLOCK TO FINALIZE SIGNUP AFTER OTP VERIFICATION
                              } else if (otpProvider.getIntent() == OtpIntent.RESET_PASS) {
                                otpProvider.setIntent(OtpIntent.RESET_PASS);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, '/resetPass');
                                }
                              } // ELSE BLOCK TO REDIRECT TO RESET PASSWORD SCREEN IF INTENT IS TO RESET PASSWORD
                            } else {
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(MySnackbars.error('Failed to verify OTP'));
                              }
                            } // ELSE BLOCK TO SHOW ERROR IF OTP VERIFICATION FAILED
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(MySnackbars.error('Invalid OTP'));
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
