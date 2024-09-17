import 'package:app/modules/authentication/Login/bloc/login_bloc.dart';
import 'package:app/modules/authentication/SignuUp/signup_page.dart';
import 'package:app/modules/authentication/otp/email_otp.dart';
import 'package:app/modules/forgetpassword/forgetpassword_page.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/shared/ui/widgets/heading.dart';
import 'package:app/shared/ui/widgets/primaryButton.dart';
import 'package:app/shared/ui/widgets/textButton.dart';
import 'package:app/shared/ui/widgets/textformfield.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    TextEditingController _textEmailController = TextEditingController();
    TextEditingController _textPasswordController = TextEditingController();
    final _loginBloc = new LoginBloc();

    return Scaffold(
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }

            if (state is EmailNotVerified) {
              print('here');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailOtp(
                    userEmail: state.email,
                  ),
                ),
              );
            }

            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content:
                      Center(child: Text('Username or password incorrect')),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: _deviceHeight,
                width: _deviceWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/forest.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        hSpace(_deviceHeight * 0.4),
                        // Heading(
                        //     text: 'Log In',
                        //     size: TextSizes.headingSize,
                        //     weight: FontWeight.bold,
                        //     color: Colors.white),
                        // hSpace(20),
                        TextFormField(
                          controller: _textEmailController,
                          validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill this field';
                          }
                        },
                          
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                        
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'circular',
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.4)),

                            filled: true,
                            fillColor: FormColors.fieldBackgroundColor
                                .withOpacity(0.25),
                            //enabled
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor, width: 2),
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            contentPadding: fieldPadding,

                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),                        
                        hSpace(20),
                        TextFormField(
                          controller: _textPasswordController,
                          validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill this field';
                          }
                        },
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'circular',
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.4)),

                            filled: true,
                            fillColor: FormColors.fieldBackgroundColor
                                .withOpacity(0.25),
                            //enabled
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor, width: 2),
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            contentPadding: fieldPadding,

                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                        hSpace(20),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              label: 'Log In',
                              width: 100,
                              onPressed: () {
                                context.read<LoginBloc>().add(UserLogin(
                                    email: _textEmailController.text,
                                    password: _textPasswordController.text));
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            onTap: () => {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPassword(),
                                ),
                              )
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'forget password? ',
                                ),
                                // TextSpan(
                                //     text: ' Signup Now! ',
                                //     style: TextStyle(color: Colors.blue)),
                              ]),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              )
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'New to pokedex?',
                                ),
                                TextSpan(
                                    text: ' Signup Now! ',
                                    style: TextStyle(color: Colors.blue)),
                              ]),
                            ),
                          ),
                        )
                        // hSpace(20),
                        // MyTextButton(
                        //   label: 'SignUp!',
                        //   width: 100,
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => SignUpPage(),
                        //         ));
                        //   },
                        // ),
                        // hSpace(10),
                        // MyTextButton(
                        //   label: 'forgot password?',
                        //   width: 200,
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => ForgetPassword(),
                        //         ));
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
