

import 'package:felicidade/common/utils/strings.dart';

String? commonValidation(String? value,String error) {
  return value != null && value.trim().isNotEmpty
      ? null
      : error??"";
}

String? validateEmailAddress(String? value) {
  if (value!.trim().isEmpty) {
    return Strings.errorEmail;
  }
  if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return Strings.validEmail;
  }
  return null;
}