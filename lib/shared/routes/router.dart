import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/no_internet/no_internet_page.dart';
import 'package:app/modules/otp_verification/otp_verification_page.dart';
import 'package:app/modules/reset_password/reset_password.dart';
import 'package:app/modules/screens/splash_screen.dart';
import 'package:app/modules/sign_up/sign_up_page.dart';
import 'package:app/modules/verify_email/veryify_email_page.dart';
import 'package:app/modules/videos/play_video.dart';
import 'package:app/modules/videos/video_page.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
  static String login = "/login";
  static String home = "/home";
  static String splash = "/";
  static String items = "/items";
  static String signup = "/signup";
  static String verifyEmail = "/verifyEmail";
  static String enterOTP = "/otp";
  static String resetPass = "/resetPass";
  static String noInternet = "/noInternet";
  static String videos = "/videos";
  static String playVideo = "/playVideo";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      splash: (context) => SplashScreen(),
      login: (context) => LoginPage(),
      home: (context) => HomePage(),
      items: (context) => ItemsPage(),
      signup: (context) => SignUpPage(),
      verifyEmail: (context) => VerifyEmailPage(),
      enterOTP: (context) => OtpVerificationPage(),
      resetPass: (context) => ResetPasswordPage(),
      noInternet: (context) => NoInternetPage(),
      videos: (context) => VideoPage(),
    };
  }
}
