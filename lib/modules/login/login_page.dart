import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mediumBlue,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [],
            ),
            Image.asset('assets/images/ash_blue.png'),

            // THIS HAS BEEN CHANGED BY PREM
          ],
        ),
      ),
    );
  }
}
