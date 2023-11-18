import 'dart:convert';

import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
const String apiHome = 'https://090e-2405-201-f00c-3016-f8f7-65ee-3667-e656.ngrok-free.app';
const String loginEndpoint = '$apiHome/auth/login';
const String signupEndpoint = '$apiHome/users/sign-up';

class AuthService {
  Future<void> apiTest() async {
    final response = await dio.get(apiHome);
    print(response.data);
  }

  Future<String?> login(String username, String password) async {
    final response = await dio.post(
      loginEndpoint,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);
      final String token = data['access_token'];
      return token;
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  ///////////////////////////

  Future<bool> userSignup(
    BuildContext context, {
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await dio.post(signupEndpoint, data: {
        'name': username,
        'email': email,
        'phone_number': phone,
        'password': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackbars.errorSnackbar('Error: User with this email already exits'));
        throw Exception('${response.statusCode} User with this email already exits');
      }
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(CustomSnackbars.errorSnackbar('Error: Signup Failed'));
      // throw Exception('Signup failed: $e');
    }
    return false;
  }
}
