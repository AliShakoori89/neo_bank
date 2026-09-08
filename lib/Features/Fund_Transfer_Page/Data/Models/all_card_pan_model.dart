import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/ali_card_pan_entity.dart';

class AllCardPanModel {
  final List<AllCardsPansDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  AllCardPanModel({this.data, this.success, this.traceId, this.error});

  factory AllCardPanModel.fromJson(Map<String, dynamic> json) {
    return AllCardPanModel(
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

  AliCardPanEntity toEntity(){
    return AliCardPanEntity(
      pan: pan,
      expireDate: expireDate,
      depositNumber: depositNumber,
      availableBalance: availableBalance
    );
  }
}