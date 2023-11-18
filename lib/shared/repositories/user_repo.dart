import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();
const String apiHome = 'https://090e-2405-201-f00c-3016-f8f7-65ee-3667-e656.ngrok-free.app';
const String loginEndpoint = '$apiHome/auth/login';
const String signupEndpoint = '$apiHome/users/';

class UserRepo {
  Future<void> dioTest() async {
    final response = await dio.get(apiHome);
    print(response.data);
  }

  Future<bool> userLogin(String email, String password) async {
    try {
      final response = await dio.post(loginEndpoint, data: {
        'user': email,
        'password': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success');
        return true;
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
    return false;
  }

  Future<bool> userSignup(
    BuildContext context, {
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await dio.post(loginEndpoint, data: {
        'name': username,
        'email': email,
        'phone': phone,
        'password': password,
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackbars.errorSnackbar('Error: Unable to sign up'));
      throw Exception('Signup failed: $e');
    }
    return false;
  }
}
