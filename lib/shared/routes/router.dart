import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
  static String home = "/";
  static String items = "/items";
  static String login = "/login";
  static String signup = "/signup";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      home: (context) => HomePage(),
      items: (context) => ItemsPage(),
      login: (context) => LoginPage(),
      signup: (context) => SignUpPage(),
    };
  }
}
