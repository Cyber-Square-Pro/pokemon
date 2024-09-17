import 'package:app/modules/forgetpassword/confirmpassword_page.dart';
import 'package:app/shared/ui/widgets/heading.dart';
import 'package:app/shared/ui/widgets/primaryButton.dart';
import 'package:app/shared/ui/widgets/textButton.dart';
import 'package:app/shared/ui/widgets/textformfield.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
      final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          decoration: BoxDecoration(
         color: Color.fromARGB(255, 155, 202, 240)
          ),
          
          child:  Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 60),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Column(
                  
                  children: [
                    hSpace(250),
                    Heading(text: 'Forget Password?', size: TextSizes.headingSize, weight: FontWeight.bold, color: Colors.white),
                    hSpace(20),
                    // PokeTextField(
                    //   prefixIcon: Icons.email_outlined,
                    // label: 'your email',
                    // ),  
                    // hSpace(20),
                    // PokeTextField(
                    //   prefixIcon: Icons.email_outlined,
                    // label: 'verification code',
                    // ),
                    // hSpace(20),
                  PrimaryButton(
                      label: 'Next', 
                      onPressed:  () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPassword(),));
                      }, 
                      width: 100)                                                        
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}