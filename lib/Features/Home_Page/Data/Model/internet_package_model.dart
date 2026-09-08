import 'package:equatable/equatable.dart';
import '../../../../Core/Network/Models/api_error_model.dart';
import 'buy_internet_model.dart';

class InternetPackageModel extends Equatable {
  final List<InternetPackage> data;
  final bool success;
  final String traceId;
  final ApiErrorModel? error;
  final String? message; // برای پیام خطا
  final String? dataString; // برای پاسخ String ساده

  const InternetPackageModel({
    required this.data,
    required this.success,
    required this.traceId,
    this.error,
    this.message,
    this.dataString,
  });

  // Factory برای پاسخ موفق با دیتا
  factory InternetPackageModel.success() {
    return const InternetPackageModel(
      data: [],
      success: true,
      traceId: '',
      error: null,
      message: 'خرید با موفقیت انجام شد',
      dataString: null,
    );
  }

  // Factory برای پاسخ موفق با دیتا String
  factory InternetPackageModel.successWithData(String dataString) {
    return InternetPackageModel(
      data: [],
      success: true,
      traceId: '',
      error: null,
      message: 'خرید با موفقیت انجام شد',
      dataString: dataString,
    );
  }

  // Factory برای خطا
  factory InternetPackageModel.error(String errorMessage) {
    return InternetPackageModel(
      data: [],
      success: false,
      traceId: '',
      error: ApiErrorModel(errorMessage: errorMessage),
      message: errorMessage,
      dataString: null,
    );
  }

  // Factory برای خطا با مدل ErrorModel
  factory InternetPackageModel.failure(BuyInternetModel error) {
    return InternetPackageModel(
      data: [],
      success: false,
      traceId: '',
      error: ApiErrorModel(errorMessage: error.errorMessage),
      message: error.errorMessage,
      dataString: null,
    );
  }

  factory InternetPackageModel.fromJson(Map<String, dynamic> json) {
    return InternetPackageModel(
      data: json['data'] != null && json['data'] is List
          ? (json['data'] as List)
          .map((e) => InternetPackage.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      success: json['success'] as bool? ?? false,
      traceId: json['traceId'] as String? ?? '',
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
      message: json['message'] as String?,
      dataString: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'success': success,
      'traceId': traceId,
      'error': error,
      'message': message,
      'dataString': dataString,
    };
  }

  // Getter برای بررسی موفقیت
  bool get isSuccess => success;

  // Getter برای بررسی خطا
  bool get isError => !success;

  // Getter برای پیام مناسب
  String get displayMessage {
    if (success) {
      return message ?? 'عملیات با موفقیت انجام شد';
    }
    if (error != null) {
      return error!.errorMessage!;
    }
    return message ?? 'خطا در انجام عملیات';
  }

  @override
  List<Object?> get props => [data, success, traceId, error, message, dataString];
}

class InternetPackage extends Equatable {
  final String operatorName;
  final int productCode;
  final int packageTimeCode;
  final String packageTime;
  final String duration;
  final String traffic;
  final String nightTraffic;
  final int price;
  final int priceWithTax;
  final int simType;
  final String simTypeDesc;
  final String description;
  final String giftTraffic;

  const InternetPackage({
    required this.operatorName,
    required this.productCode,
    required this.packageTimeCode,
    required this.packageTime,
    required this.duration,
    required this.traffic,
    required this.nightTraffic,
    required this.price,
    required this.priceWithTax,
    required this.simType,
    required this.simTypeDesc,
    required this.description,
    required this.giftTraffic,
  });

  factory InternetPackage.fromJson(Map<String, dynamic> json) {
    return InternetPackage(
      operatorName: json['operatorName'] as String? ?? '',
      productCode: json['productCode'] as int? ?? 0,
      packageTimeCode: json['packageTimeCode'] as int? ?? 0,
      packageTime: json['packageTime'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      traffic: json['traffic'] as String? ?? '',
      nightTraffic: json['nightTraffic'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      priceWithTax: json['priceWithTax'] as int? ?? 0,
      simType: json['simType'] as int? ?? 0,
      simTypeDesc: json['simTypeDesc'] as String? ?? '',
      description: json['description'] as String? ?? '',
      giftTraffic: json['giftTraffic'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operatorName': operatorName,
      'productCode': productCode,
      'packageTimeCode': packageTimeCode,
      'packageTime': packageTime,
      'duration': duration,
      'traffic': traffic,
      'nightTraffic': nightTraffic,
      'price': price,
      'priceWithTax': priceWithTax,
      'simType': simType,
      'simTypeDesc': simTypeDesc,
      'description': description,
      'giftTraffic': giftTraffic,
    };
  }

  @override
  List<Object?> get props => [
    operatorName,
    productCode,
    packageTimeCode,
    packageTime,
    duration,
    traffic,
    nightTraffic,
    price,
    priceWithTax,
    simType,
    simTypeDesc,
    description,
    giftTraffic,
  ];
}
