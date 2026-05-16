class InternetPackageModel {
  final String? operatorName;
  final int? productCode;
  final int? packageTimeCode;
  final String? packageTime;
  final String? duration;
  final String? traffic;
  final dynamic nightTraffic; // چون می‌تواند null باشد
  final int? price;
  final int? priceWithTax;
  final int? simType;
  final String? simTypeDesc;
  final String? description;
  final dynamic giftTraffic; // چون می‌تواند null باشد

  InternetPackageModel({
    this.operatorName,
    this.productCode,
    this.packageTimeCode,
    this.packageTime,
    this.duration,
    this.traffic,
    this.nightTraffic,
    this.price,
    this.priceWithTax,
    this.simType,
    this.simTypeDesc,
    this.description,
    this.giftTraffic,
  });

  factory InternetPackageModel.fromJson(Map<String, dynamic> json) {
    return InternetPackageModel(
      operatorName: json['operatorName']?.toString().replaceAll('"', '').trim(),
      productCode: json['productCode'] as int?,
      packageTimeCode: json['packageTimeCode'] as int?,
      packageTime: json['packageTime'] as String?,
      duration: json['duration'] as String?,
      traffic: json['traffic'] as String?,
      nightTraffic: json['nightTraffic'],
      price: json['price'] as int?,
      priceWithTax: json['priceWithTax'] as int?,
      simType: json['simType'] as int?,
      simTypeDesc: json['simTypeDesc'] as String?,
      description: json['description'] as String?,
      giftTraffic: json['giftTraffic'],
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
}