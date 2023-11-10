import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void changeScreen() async{
    Future.delayed(const Duration(milliseconds: 2200),() {
      Navigator.pushNamed(context, '/login');
    },);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg/login_bg.png'),
          )
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Lottie.asset('assets/lotties/splashanimation.json', height: 250, width: 250)),

          ],
        ),
        
      ),
    );
  }
}