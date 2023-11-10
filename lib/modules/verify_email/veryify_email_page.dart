import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/custom_text_form_field.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _reenteremailcontroller = TextEditingController();

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
                  'Verify Your Email',
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
                    hSpace(5),
                    Text(
                      'Please re-enter your email, An OTP Number will be sent to this email shortly.',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: pageSubtitle,
                    ),
                    hSpace(20),
                     CustomTextFormField(
                      controller: _reenteremailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: Icons.email,
                      labelText: 'Re-enter your email',
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
