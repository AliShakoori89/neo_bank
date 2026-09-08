import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/deposit_entity.dart';

class DepositsModel {
  final List<DepositsDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  DepositsModel({this.data, this.success, this.traceId, this.error});

  factory DepositsModel.fromJson(Map<String, dynamic> json) {
    return DepositsModel(
      data: json['data'] != null
          ? List<DepositsDataModel>.from(
              json['data'].map((x) => DepositsDataModel.fromJson(x)),
            )
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class DepositsDataModel {
  final int? availableBalance;
  final String? depositNumber;
  final String? depositTitle;
  final DateTime? expireDate;
  final String? ibanNumber;

  DepositsDataModel({
    this.availableBalance,
    this.depositNumber,
    this.depositTitle,
    this.expireDate,
    this.ibanNumber,
  });

  factory DepositsDataModel.fromJson(Map<String, dynamic> json) {
    return DepositsDataModel(
      availableBalance: json['availableBalance'] as int?,
      depositNumber: json['depositNumber'] as String?,
      depositTitle: json['depositTitle'] as String?,
      ibanNumber: json['ibanNumber'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
    );
  }

  DepositEntity toEntity(){
    return DepositEntity(
      availableBalance: availableBalance,
      depositNumber: depositNumber,
      expireDate: expireDate,
      depositTitle: depositTitle,
      ibanNumber: ibanNumber
    );
  }
}
