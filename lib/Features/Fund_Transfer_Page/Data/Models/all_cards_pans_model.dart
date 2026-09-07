import '../../../../Core/Network/Models/api_error_model.dart';

class AllCardsPansModel {
  final List<AllCardsPansDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  AllCardsPansModel({this.data, this.success, this.traceId, this.error});

  factory AllCardsPansModel.fromJson(Map<String, dynamic> json) {
    return AllCardsPansModel(
      data: json['data'] != null
          ? List<AllCardsPansDataModel>.from(
              json['data'].map((x) => AllCardsPansDataModel.fromJson(x)),
            )
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class AllCardsPansDataModel {
  final String? depositNumber;
  final DateTime? expireDate;
  final String? pan;
  final int? availableBalance;

  AllCardsPansDataModel({
    this.depositNumber,
    this.expireDate,
    this.pan,
    this.availableBalance,
  });

  factory AllCardsPansDataModel.fromJson(Map<String, dynamic> json) {
    return AllCardsPansDataModel(
      depositNumber: json['depositNumber'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
      pan: json['pan'] as String?,
      availableBalance: json['availableBalance'] as int?,
    );
  }
}