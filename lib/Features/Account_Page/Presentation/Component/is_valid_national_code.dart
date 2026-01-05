bool isValidIranianNationalCode(String code) {
  if (code.length != 10) return false;

  // فقط عدد باشد
  if (!RegExp(r'^\d{10}$').hasMatch(code)) return false;

  final digits = code.split('').map(int.parse).toList();
  final control = digits[9];

  int sum = 0;
  for (int i = 0; i < 9; i++) {
    sum += digits[i] * (10 - i);
  }

  final remainder = sum % 11;

  if (remainder < 2) {
    return control == remainder;
  } else {
    return control == (11 - remainder);
  }
}
