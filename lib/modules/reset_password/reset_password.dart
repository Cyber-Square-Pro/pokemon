import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/password_obscure_provider.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                        Consumer<ObscureProvider>(
                          builder: (context, provider, _) => Column(
                            children: [
                              CustomTextFormField(
                                controller: _newpasswordcontroller,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                                isPassword: provider.obscureResetPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureResetPassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                  ),
                                  onPressed: () {
                                    provider.toggleResetPasswordHidden();
                                  },
                                ),
                                prefixIcon: Icons.lock_reset,
                                labelText: 'New Password',
                              ),
                              hSpace(20),
                              CustomTextFormField(
                                controller: _confirmpasswordcontroller,
                                validator: (value) {
                                  if (value == '' || value != _newpasswordcontroller.text) {
                                    return 'Confirmed password does not match!!!';
                                  }
                                  return null;
                                },
                                isPassword: provider.obscureResetConfirmPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureResetConfirmPassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                  ),
                                  onPressed: () {
                                    provider.toggleResetPasswordConfirmHidden();
                                  },
                                ),
                                prefixIcon: Icons.lock_reset,
                                labelText: 'Confirm Password',
                              ),
                            ],
                          ),
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
                                showLoadingSpinnerModal(context, 'Resetting password...');
                                final email = otpProvider.email;
                                if (await OtpService()
                                    .resetPassword(email, _newpasswordcontroller.text.trim())) {
                                  if (context.mounted) {
                                    Provider.of<ObscureProvider>(context, listen: false)
                                        .resetSettings();
                                    Navigator.popAndPushNamed(
                                      context,
                                      '/login',
                                      arguments: [
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          MySnackbars.success(
                                              'Password has been reset, login to continue'),
                                        ),
                                      ],
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.error('Failed To Reset Password'));
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(MySnackbars.error(
                                    'Passwords do not match / Invalid passwords'));
                              }
                            },
                          ),
                        ),
                        hSpace(20),
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
