String convertPhoneNumber(String phoneNumber) {
  if (phoneNumber.startsWith('+98')) {
    return phoneNumber.replaceFirst('+98', '0');
  }
  return phoneNumber;
}