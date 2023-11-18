class FormValidator {
  String? validatePassword(String value) {
    if (value == '') {
      return 'Password cannot be blank';
    } else if (value.length < 6) {
      return 'Password needs to be atleast 6 characters';
    } else if (value.contains(RegExp(r' '))) {
      return 'Password cannot contain spaces';
    }
    return null;
  }
}
