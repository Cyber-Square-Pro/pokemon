import 'package:app/modules/login/login_page.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_button.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';

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
            hSpace(120),
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
                horizontal: 40,
              ),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _namecontroller,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.person,
                      labelText: 'Username',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _phonenumbercontroller,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.phone_android,
                      labelText: 'Phone Number',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _emailaddresscontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.email,
                      labelText: 'Email Address',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _passwordcontroller,
                      isPassword: true,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.lock_outline,
                      labelText: 'Enter Password',
                    ),
                    hSpace(20),
                    CustomTextFormField(
                      controller: _confirmpasswordcontroller,
                      isPassword: true,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.lock,
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
                        label: 'Sign Up',
                        onPressed: () {},
                      ),
                    ),
                    hSpace(15),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
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
    );
  }
}
