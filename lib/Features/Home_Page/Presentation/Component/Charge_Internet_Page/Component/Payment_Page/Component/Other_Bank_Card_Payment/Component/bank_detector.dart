import 'bank_info.dart';

class BankDetector {
  final Map<String, BankInfo> banks;

  BankDetector(this.banks);

  BankInfo? detect(String cardNumber) {
    String cleanedNumber = cardNumber.replaceAll(' ', '');

    if (cleanedNumber.length >= 4) {
      String bin = cleanedNumber.substring(0, 4);
      return banks[bin];
    }

    return null;
  }
}