import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Data/Model/statement_model.dart';

enum StatementStateStatus { initial, success, error, loading }

extension UserLoginAuthStatusX on StatementStateStatus {
  bool get isInitial => this == StatementStateStatus.initial;
  bool get isSuccess => this == StatementStateStatus.success;
  bool get isError => this == StatementStateStatus.error;
  bool get isLoading => this == StatementStateStatus.loading;
}

class StatementState extends Equatable {
  const StatementState({
    required this.status,
    required this.topStatement,
    required this.allStatement,
  });

  static StatementState initial() => StatementState(
    status: StatementStateStatus.initial,
    topStatement: [],
    allStatement: [],
  );

  final StatementStateStatus status;
  final List<StatementDataModel> topStatement;
  final List<StatementDataModel> allStatement;

  @override
  List<Object?> get props => [status, topStatement, allStatement];

  StatementState copyWith({
    StatementStateStatus? status,
    List<StatementDataModel>? topStatement,
    List<StatementDataModel>? allStatement,
  }) {
    return StatementState(
      status: status ?? this.status,
      topStatement: topStatement ?? this.topStatement,
      allStatement: allStatement ?? this.allStatement,
    );
  }
}
