class CardListModel {
  final List<CardDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiError? error;

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
      error: json['error'] != null ? ApiError.fromJson(json['error']) : null,
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

  List<Object?> get props => [
    pan, // 👈 identity اصلی
    availableBalance, // اگه تغییر کرد → rebuild
  ];
}

class ApiError {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  ApiError({this.errorCode, this.errorMessage, this.owner});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
