class StatementModel {
  final List<StatementDataModel>? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  StatementModel({this.data, this.success, this.traceId, this.error});

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    return StatementModel(
      data: json['data'] != null
          ? List<StatementDataModel>.from(
              json['data'].map((x) => StatementDataModel.fromJson(x)),
            )
          : null,
      success: json['success'] as bool?,
      traceId: json['traceId'] as String?,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class StatementDataModel {
  final DateTime? date;
  final int? transferAmount;
  final int? balance;
  final int? action;
  final String? description;

  StatementDataModel({
    this.date,
    this.transferAmount,
    this.balance,
    this.action,
    this.description,
  });

  factory StatementDataModel.fromJson(Map<String, dynamic> json) {
    return StatementDataModel(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      transferAmount: json['transferAmount'] as int,
      balance: json['balance'] as int,
      action: json['action'] as int,
      description: json['description'] as String,
    );
  }
}

class ApiErrorModel {
  final int? errorCode;
  final String? errorMessage;
  final String? owner;

  ApiErrorModel({this.errorCode, this.errorMessage, this.owner});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
