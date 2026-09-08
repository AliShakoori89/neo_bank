import '../../../../Core/Network/Models/api_error_model.dart';
import '../../Domain/Entities/statement_entity.dart';

class StatementResponseModel {
  final StatementDataModel? data;
  final bool? success;
  final String? traceId;
  final ApiErrorModel? error;

  StatementResponseModel({
    this.data,
    this.success,
    this.traceId,
    this.error,
  });

  factory StatementResponseModel.fromJson(Map<String, dynamic> json) {
    return StatementResponseModel(
      data: json['data'] != null
          ? StatementDataModel.fromJson(json['data'])
          : null,
      success: json['success'],
      traceId: json['traceId'],
      error: json['error'],
    );
  }
}

class StatementDataModel {
  final bool? hasMoreItem;
  final List<StatementModel>? statements;

  StatementDataModel({
    this.hasMoreItem,
    this.statements,
  });

  factory StatementDataModel.fromJson(Map<String, dynamic> json) {
    return StatementDataModel(
      hasMoreItem: json['hasMoreItem'],
      statements: (json['statements'] as List?)
          ?.map((e) => StatementModel.fromJson(e))
          .toList(),
    );
  }

  StatementEntity toEntity() {
    return StatementEntity(
      hasMoreItem: hasMoreItem,
      statements: statements
          ?.map((statement) => statement.toEntity())
          .toList(),
    );
  }
}

class StatementModel {
  final DateTime? date;
  final int? transferAmount;
  final String? actionDescription;
  final String? description;
  final String? referenceNumber;

  StatementModel({
    this.date,
    this.transferAmount,
    this.actionDescription,
    this.description,
    this.referenceNumber,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    return StatementModel(
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : null,
      transferAmount: json['transferAmount'],
      actionDescription: json['actionDescription'],
      description: json['description'],
      referenceNumber: json['referenceNumber'],
    );
  }

  StatementItemEntity toEntity() {
    return StatementItemEntity(
      date: date,
      transferAmount: transferAmount,
      actionDescription: actionDescription,
      description: description,
      referenceNumber: referenceNumber,
    );
  }
}


