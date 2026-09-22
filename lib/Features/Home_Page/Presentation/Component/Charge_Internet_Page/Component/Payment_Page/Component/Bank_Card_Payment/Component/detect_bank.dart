import 'bank_info.dart';

/// متد تشخیص بانک از روی شماره کارت
BankInfo? detectBank(String cardNumber, Map<String, BankInfo> banks) {
  String cleanedNumber = cardNumber.replaceAll(' ', '');

  if (cleanedNumber.length >= 4) {
    String bin = cleanedNumber.substring(0, 4);
    if (banks.containsKey(bin)) {
      return banks[bin];
    }
  }

  return null;
}

/// Extension برای راحتی کار
extension BankDetectionExtension on String {
  BankInfo? detectBankFromCardNumber(Map<String, BankInfo> banks) {
    return detectBank(this, banks);
  }
}