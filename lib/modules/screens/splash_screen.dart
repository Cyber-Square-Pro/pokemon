import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() async {
    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        Navigator.popAndPushNamed(context, '/login');
      },
    );
  }

  @override
  void initState() {
    super.initState();

    checkIfCredentialsExistOnDevice();
    changeScreen();
  }

  Future<void> checkIfCredentialsExistOnDevice() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username') && prefs.containsKey('password')) {
      showLoadingSpinnerModal(context, 'Auto logging in...');
      final username = prefs.getString('username')!;
      final password = prefs.getString('password')!;
      if (await AuthService().login(username, password)) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pop(context);
        context.read<AuthProvider>().logout(context);
        ScaffoldMessenger.of(context).showSnackBar(
          MySnackbars.error('Auto login failed'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bg/login_bg.png'),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/lotties/splashanimation.json',
                height: 400,
                width: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
