String convertPhoneNumber(String phoneNumber) {
  String cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-()]'), '');

  if (cleaned.startsWith('+98')) {
    return cleaned.replaceFirst('+98', '0');
  }
  return cleaned;
}