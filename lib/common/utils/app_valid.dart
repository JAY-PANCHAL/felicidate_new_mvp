

String? commonValidation(String? value,String error) {
  return value != null && value.trim().isNotEmpty
      ? null
      : error??"";
}