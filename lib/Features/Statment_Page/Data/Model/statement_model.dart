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
  final String? actionDescription;
  final String? description;

  StatementDataModel({
    this.date,
    this.transferAmount,
    this.actionDescription,
    this.description,
  });

  factory StatementDataModel.fromJson(Map<String, dynamic> json) {
    return StatementDataModel(
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,

      transferAmount: (json['transferAmount'] as num?)?.toInt(),

      actionDescription: (json['actionDescription']?.toString()),

      description: json['description']?.toString(),
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
