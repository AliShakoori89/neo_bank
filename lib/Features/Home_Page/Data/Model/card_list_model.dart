import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/card_list_entity.dart';

class CardListModel {
  final List<CardDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  CardListModel({this.data, this.success, this.traceId, this.error});

  factory CardListModel.fromJson(Map<String, dynamic> json) {
    return CardListModel(
      data: json['data'] != null
          ? List<CardDataModel>.from(
              json['data'].map((x) => CardDataModel.fromJson(x)),
            )
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class CardDataModel {
  final String? depositNumber;
  final DateTime? expireDate;
  final String? pan;
  final String? cardDeposit;
  final int? availableBalance;

  CardDataModel({
    this.depositNumber,
    this.expireDate,
    this.pan,
    this.cardDeposit,
    this.availableBalance,
  });

  factory CardDataModel.fromJson(Map<String, dynamic> json) {
    return CardDataModel(
      depositNumber: json['depositNumber'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
      pan: json['pan'] as String?,
      cardDeposit: json['cardDeposit'] as String?,
      availableBalance: json['availableBalance'] as int?,
    );
  }

  CardEntity toEntity(){
    return CardEntity (
      availableBalance: availableBalance,
      cardDeposit: cardDeposit,
      depositNumber: depositNumber,
      expireDate: expireDate,
      pan: pan
    );
  }

  List<Object?> get props => [
    pan, // 👈 identity اصلی
    availableBalance, // اگه تغییر کرد → rebuild
  ];
}

