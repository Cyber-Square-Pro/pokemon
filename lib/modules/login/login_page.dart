import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/providers/otp_provider.dart';
import 'package:app/shared/providers/password_obscure_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  // Auth
  final authService = AuthService();
  @override
  void initState() {
    super.initState();
    checkIfCredentialsExistOnDevice();
  }

  Future<void> checkIfCredentialsExistOnDevice() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username') && prefs.containsKey('password')) {
      showLoadingSpinnerModal(context, 'Auto logging in...');
      final username = prefs.getString('username')!;
      final password = prefs.getString('password')!;
      final AuthState loginResult = await AuthService().login(username, password);
      if (loginResult == AuthState.LOGIN_SUCCESS) {
        context.read<AuthProvider>().getUserInfo();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pop(context);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
                hSpace(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/pokeball.png',
                      width: 40.w,
                    ),
                    wSpace(5),
                    Text(
                      'Log In',
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
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter a valid username';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.person,
                          labelText: 'Username',
                        ),
                        hSpace(20),
                        // Password text field

                        Consumer<ObscureProvider>(
                          builder: (context, provider, _) => CustomTextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == '' || value == null) {
                                return 'Please enter a valid password';
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                context.read<ObscureProvider>().obscurePassword
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                              ),
                              onPressed: () {
                                context.read<ObscureProvider>().toggleLoginPasswordHidden();
                              },
                            ),
                            isPassword: context.read<ObscureProvider>().obscurePassword,
                            prefixIcon: Icons.lock,
                            labelText: 'Password',
                          ),
                        ),
                        hSpace(15),
                        CustomTextButton(
                          onPressed: () {
                            otpProvider.setIntent(OtpIntent.RESET_PASS);
                            Provider.of<ObscureProvider>(context, listen: false).resetSettings();
                            Navigator.pushNamed(context, '/verifyEmail');
                          },
                          label: 'Forgot Password? Click Here',
                        ),
                        hSpace(15),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.black.withOpacity(0.25),
                            )
                          ]),
                          child: CustomElevatedButton(
                            label: 'Log In',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                showLoadingSpinnerModal(context, 'Logging In');
                                final AuthState loginResult = await authService.login(
                                    _usernameController.text.trim(),
                                    _passwordController.text.trim());
                                print(loginResult);
                                if (loginResult == AuthState.LOGIN_SUCCESS) {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    Provider.of<ObscureProvider>(context, listen: false)
                                        .resetSettings();
                                    authProvider.setAuthenticated(true);
                                    authProvider.getUserInfo();
                                    Navigator.pushReplacementNamed(context, '/home', arguments: [
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(MySnackbars.success('Welcome to Pokedex')),
                                    ]);
                                  }
                                } else if (loginResult == AuthState.EMAIL_NOT_VERIFIED) {
                                  otpProvider.setIntent(OtpIntent.SIGN_UP);

                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/verifyEmail', arguments: [
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackbars.error('Please verify your email first')),
                                  ]);
                                } else {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(MySnackbars.error(
                                        'Login Failed: Please check your credentials'));
                                  }
                                }
                                // Navigate to secured screen on successful login
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(MySnackbars.error('Invalid submission!'));
                              }
                            },
                          ),
                        ),
                        hSpace(15),
                        CustomTextButton(
                          onPressed: () {
                            otpProvider.setIntent(OtpIntent.SIGN_UP);
                            Provider.of<ObscureProvider>(context, listen: false).resetSettings();
                            Navigator.pushNamed(context, '/signup');
                          },
                          label: 'Dont have an account? Sign Up.',
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
