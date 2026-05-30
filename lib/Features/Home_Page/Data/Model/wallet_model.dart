import 'package:equatable/equatable.dart';

class WalletResponseModel extends Equatable {
  final List<WalletModel> data;
  final bool success;
  final String traceId;
  final dynamic error;

  const WalletResponseModel({
    required this.data,
    required this.success,
    required this.traceId,
    this.error,
  });

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List? ?? [];

    return WalletResponseModel(
      data: dataList.map((item) => WalletModel.fromJson(item)).toList(),
      success: json['success'] as bool? ?? false,
      traceId: json['traceId'] as String? ?? '',
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'success': success,
      'traceId': traceId,
      'error': error,
    };
  }

  @override
  List<Object?> get props => [data, success, traceId, error];
}


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