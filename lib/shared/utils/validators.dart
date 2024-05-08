import 'package:intl_phone_field/phone_number.dart';

class FormValidators {
  FormValidators._();

  static String? validatePassword(String? value) {
    if (value == null || value == '') {
      return 'Password cannot be null';
    } else if (value.length < 6) {
      return 'Password must have 6 or more characters';
    } else if (value.contains(' ')) {
      return 'Password cannot have blank spaces';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? compare) {
    if (value != compare) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value == '') {
      return 'Username cannot be blank';
    } else if (value.length < 5) {
      return 'Username must have atleast 5 characters';
    } else if (value.contains(' ')) {
      return 'Username cannot have blank spaces';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == '' || value == null) {
      return 'Phone number cannot be blank';
    } else if (value.contains(' ') ||
        value.contains('.') ||
        value.contains('#')) {
      return 'Invalid phone number';
    } else if (value.length != 10) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validatePhoneField(PhoneNumber? value) {
    final String? valueText = value?.completeNumber;
    if (valueText == '' || valueText == null) {
      return 'Phone number cannot be blank';
    } else if (valueText.contains(' ') || valueText.contains('.')) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == '' || value == null) {
      return 'Email number cannot be blank';
    } else if (!value.contains('@')) {
      return 'Invalid email format';
    } else if (value.isNotEmpty && !_regex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? expiryDateValidator(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return 'Expiry date is required';
    } else if (expiryDate.length != 5) {
      return 'Invalid expiry date';
    }
    return null;
  }

  static String? cardHolderValidator(String? cardHolderName) {
    if (cardHolderName == null || cardHolderName.isEmpty) {
      return 'Cardholder name is required';
    }
    return null;
  }

  static String? cvvValidator(String? cvv) {
    if (cvv == null || cvv.isEmpty) {
      return 'CVV is required';
    } else if (cvv.length != 3) {
      return 'Invalid CVV';
    }
    return null;
  }

  static String? cardNumberValidator(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) {
      return 'Card number is required';
    } else if (cardNumber.length < 19) {
      return 'Invalid card number';
    }
    return null; // Return null if validation is successful
  }
}

const _pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
final _regex = RegExp(_pattern);
