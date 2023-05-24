import 'dart:io';

class InputValidator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    if (!RegExp(r'^[\w-\.]+@').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Perform DNS lookup to check if domain exists
    try {
      final result = InternetAddress.lookup(value.split('@')[1]);
      if (result.then((res) => res.isEmpty) == true) {
        return 'Domain does not exist';
      }
    } catch (_) {
      return 'Domain does not exist';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+?[0-9]{8,}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
  static String? idValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ID';
    }
    if (!RegExp(r'^\d{14}$').hasMatch(value)) {
      return 'ID must be 14 digits';
    }
    return null;
  }

  static String? licenseValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your license number';
    }
    if (!RegExp(r'^\d{14}$').hasMatch(value)) {
      return 'License number must be 14 digits';
    }
    return null;
  }
}

