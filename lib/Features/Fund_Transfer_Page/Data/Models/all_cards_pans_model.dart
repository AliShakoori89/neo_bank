import '../../../../Core/Network/Models/api_error_model.dart';

class AllCardsPansModel {
  final List<AllCardsPansdDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  AllCardsPansModel({this.data, this.success, this.traceId, this.error});

  factory AllCardsPansModel.fromJson(Map<String, dynamic> json) {
    return AllCardsPansModel(
      data: json['data'] != null
          ? List<AllCardsPansdDataModel>.from(
              json['data'].map((x) => AllCardsPansdDataModel.fromJson(x)),
            )
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class AllCardsPansdDataModel {
  final String? depositNumber;
  final DateTime? expireDate;
  final String? pan;
  final int? availableBalance;

  AllCardsPansdDataModel({
    this.depositNumber,
    this.expireDate,
    this.pan,
    this.availableBalance,
  });

  factory AllCardsPansdDataModel.fromJson(Map<String, dynamic> json) {
    return AllCardsPansdDataModel(
      depositNumber: json['depositNumber'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
      pan: json['pan'] as String?,
      availableBalance: json['availableBalance'] as int?,
    );
  }
}