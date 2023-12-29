import 'package:flutter/material.dart';

class CreditCardProvider extends ChangeNotifier {
  late String _cardNumber = '';
  late String _expiryDate = '';
  late String _cardHolderName = '';
  late String _cvvCode = '';

  late bool _showBackView = false;
  late bool _saveButtonVisible = false;

  void setCardDetails({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
    required String cardHolderName,
    required bool showBackView,
  }) {
    _cardHolderName = cardHolderName;
    _expiryDate = expiryDate;
    _cvvCode = cvvCode;
    _cardNumber = cardNumber;
    _showBackView = showBackView;
    notifyListeners();
  }

  void cardEntryCompleted() {
    _saveButtonVisible = true;
    notifyListeners();
  }

  void clearAll() {
    _cardHolderName = '';
    _cardNumber = '';
    _cvvCode = '';
    _expiryDate = '';
    _showBackView = false;
    _saveButtonVisible = false;
    notifyListeners();
  }

  String get cardNumber => _cardNumber;
  String get cvv => _cvvCode;
  String get cardHolderName => _cardHolderName;
  String get expiry => _expiryDate;

  bool get showBackView => _showBackView;
  bool get saveButtonVisible => _saveButtonVisible;
}
