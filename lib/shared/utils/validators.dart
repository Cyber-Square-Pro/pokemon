class FormValidators {
  String? validatePassword(String? value) {
    if (value == null || value == '') {
      return 'Password cannot be null';
    } else if (value.length < 6) {
      return 'Password must have 6 or more characters';
    } else if (value.contains(' ')) {
      return 'Password cannot have blank spaces';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? compare) {
    if (value != compare) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value == '') {
      return 'Username cannot be blank';
    } else if (value.length < 5) {
      return 'Username must have atleast 5 characters';
    } else if (value.contains(' ')) {
      return 'Username cannot have blank spaces';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == '' || value == null) {
      return 'Phone number cannot be blank';
    } else if (value.contains(' ') || value.contains('.') || value.contains('#')) {
      return 'Invalid phone number';
    } else if (value.length != 10) {
      return 'Invalid phone number';
    }
    return null;
  }
}
