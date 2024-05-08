import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  static final _key = dotenv.env['STRIPE_KEY'].toString();
  static final Dio dio = Dio();
  static Future<void> createPaymentIntent(int amount) async {
    final Map<String, dynamic> data = {
      'amount': amount,
      'currency': 'INR',
    };

    try {
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_key',
            'Content-Type': 'application/x-www-form-urlendcoded'
          },
        ),
        data: jsonEncode(data),
      );
      final Map<String, dynamic> paymentIntent = jsonDecode(response.data);
      await showPaymentSheet(paymentIntent);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> showPaymentSheet(Map<String, dynamic> intent) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: intent['client_secret'],
        merchantDisplayName: 'Pokedex TeamB',
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}
