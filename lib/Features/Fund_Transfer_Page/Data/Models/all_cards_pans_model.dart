class AllCardsPansModel {
  final List<AllCardsPansdDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiError? error;

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
      error: json['error'] != null ? ApiError.fromJson(json['error']) : null,
    );
  }
}

class AllCardsPansdDataModel {
  final String? depositNumber;
  final DateTime? expireDate;
  final String? pan;
  final String? cardDeposit;
  final int? availableBalance;

  AllCardsPansdDataModel({
    this.depositNumber,
    this.expireDate,
    this.pan,
    this.cardDeposit,
    this.availableBalance,
  });

  factory AllCardsPansdDataModel.fromJson(Map<String, dynamic> json) {
    return AllCardsPansdDataModel(
      depositNumber: json['depositNumber'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'])
          : null,
      pan: json['pan'] as String?,
      cardDeposit: json['cardDeposit'] as String?,
      availableBalance: json['availableBalance'] as int?,
    );
  }
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
