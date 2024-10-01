enum InputFormatType { name, phoneNumber, email, password }

class Validator {
  Validator.__();

  static String? validatePassword(String? value, {String? msg}) {
    String errorMsg = msg ??
        'Password must be at least 8 characters long, must contain numbers, at least one uppercase and lowercase alphabet, and must not contain spaces.';
    if ((msg ?? '').isNotEmpty) {
      return msg;
    } else if ((value ?? '').isEmpty) {
      return "Password is required";
    } else if (value!.length < 8) {
      return errorMsg;
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return errorMsg;
    } else if (!value
        .contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)\S{8,}$'))) {
      return errorMsg;
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return errorMsg;
    }
    return null;
  }

  static String? validateLoginPassword(String? value, {String? msg}) {
    if ((msg ?? '').isNotEmpty) {
      return msg;
    } else if ((value ?? '').isEmpty) {
      return "Password is required";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? oldPassword, String? newPassword) {
    if ((newPassword ?? '').isEmpty) {
      return "Confirm password is required";
    } else if (oldPassword != newPassword) {
      return "Passwords do not match. Please enter the same password in both fields.";
    }
    return null;
  }

  static String? validateEmail(String? value, {String? msg}) {
    String pattern =
        r'^(?=.{1,320}$)[a-zA-Z0-9._%+-]{1,64}@[a-zA-Z0-9.-]{1,255}\.[a-zA-Z]{2,63}$';
    RegExp regex = RegExp(pattern);
    if (msg != null) return msg;
    if ((value ?? '').isEmpty) return "Email address is required";
    if (!regex.hasMatch(value!)) {
      return "Please enter a valid email address.";
    } else {
      return null;
    }
  }

  static String? validateIsEmpty(String value, {String? returnText}) {
    if (value.isEmpty) {
      return returnText ?? '';
    } else if (value.trim() == '') {
      return returnText ?? '';
    } else {
      return null;
    }
  }
}
