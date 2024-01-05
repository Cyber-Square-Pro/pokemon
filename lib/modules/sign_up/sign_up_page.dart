import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/password_obscure_provider.dart';
import 'package:app/shared/providers/timer_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:app/shared/repositories/otp_service.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/utils/validators.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/shared/widgets/phone_form_field.dart';
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
  @override
  void initState() {
    super.initState();
  }

  final _phonenumbercontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //
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
                Text(
                  'Pokedex',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
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
                        PhoneNumberFormField(
                          controller: _phonenumbercontroller,
                          onChanged: (value) {
                            print(value.completeNumber);
                            print(_phonenumbercontroller.value);
                          },
                          validator: (value) =>
                              FormValidators.validatePhoneField(value),
                        ),
                        // hSpace(20),
                        // CustomTextFormField(
                        //   controller: _phonenumbercontroller,
                        //   keyboardType: TextInputType.phone,
                        //   validator: (value) => FormValidators().validatePhoneNumber(value),
                        //   prefixIcon: Icons.phone_android,
                        //   labelText: 'Phone Number',
                        // ),
                        hSpace(20),
                        CustomTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              FormValidators.validateEmail(value),
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
                                validator: (value) =>
                                    FormValidators.validatePassword(value),
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
                                validator: (value) =>
                                    FormValidators.validateConfirmPassword(
                                        value, _passwordcontroller.text),
                                isPassword:
                                    provider.obscureSignupConfirmPassword,
                                prefixIcon: Icons.lock,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureSignupConfirmPassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                  ),
                                  onPressed: () {
                                    provider
                                        .toggleSignupPasswordConfirmHidden();
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
                                final otpProvider = Provider.of<OtpProvider>(
                                  context,
                                  listen: false,
                                );
                                showLoadingSpinnerModal(
                                    context, 'Signing up...');

                                if (await AuthService.instance.register(
                                  username: _namecontroller.text.trim(),
                                  email: _emailController.text.trim(),
                                  phoneNumber:
                                      _phonenumbercontroller.text.trim(),
                                  password: _passwordcontroller.text.trim(),
                                )) {
                                  otpProvider.setIntent(OtpIntent.SIGN_UP);
                                  if (await OtpService().sendOTP(
                                    _emailController.text.trim(),
                                    otpProvider.intent.name,
                                  )) {
                                    otpProvider
                                        .setEmail(_emailController.text.trim());
                                    _namecontroller.clear();
                                    _emailController.clear();
                                    _phonenumbercontroller.clear();
                                    _passwordcontroller.clear();
                                    _confirmpasswordcontroller.clear();

                                    if (context.mounted) {
                                      Navigator.popAndPushNamed(
                                          context, '/otp');
                                      context
                                          .read<TimerProvider>()
                                          .restartTimer();
                                      Provider.of<ObscureProvider>(context,
                                              listen: false)
                                          .resetSettings();
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        MySnackbars.error(
                                            'A User with these credentials already exists'),
                                      );
                                    }
                                  }
                                } else {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.error(
                                            'Failed to send OTP'));
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackbars.error('Invalid Submission!'));
                              }
                            },
                          ),
                        ),
                        hSpace(15),
                        CustomTextButton(
                          onPressed: () {
                            Provider.of<ObscureProvider>(context, listen: false)
                                .resetSettings();
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
