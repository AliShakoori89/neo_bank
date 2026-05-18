// مدل کیف پول
class WalletModel {
  final String address;
  final String title;
  final int walletType;
  final bool isActive;
  final int balance;

  // سازنده اصلی
  WalletModel({
    required this.address,
    required this.title,
    required this.walletType,
    required this.isActive,
    required this.balance,
  });

  // تبدیل از JSON به آبجکت
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      address: json['address'] as String,
      title: json['title'] as String,
      walletType: json['walletType'] as int,
      isActive: json['isActive'] as bool,
      balance: json['balance'] as int,
    );
  }

  // تبدیل از آبجکت به JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'title': title,
      'walletType': walletType,
      'isActive': isActive,
      'balance': balance,
    };
  }
}