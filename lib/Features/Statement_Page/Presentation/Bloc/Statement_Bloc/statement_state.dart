import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Model/statement_model.dart';

enum StatementStateStatus { initial, success, error, loading }

extension UserLoginAuthStatusX on StatementStateStatus {
  bool get isInitial => this == StatementStateStatus.initial;
  bool get isSuccess => this == StatementStateStatus.success;
  bool get isError => this == StatementStateStatus.error;
  bool get isLoading => this == StatementStateStatus.loading;
}

class StatementState extends Equatable {
  const StatementState({required this.status, required this.allStatement, required this.hasMore, required this.isLoadingMore});

  static StatementState initial() =>
      StatementState(
          status: StatementStateStatus.initial,
          allStatement: [],
          hasMore: true,
          isLoadingMore: false);

  final StatementStateStatus status;
  final List<StatementModel> allStatement;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [status, allStatement, hasMore, isLoadingMore];

  StatementState copyWith({
    StatementStateStatus? status,
    List<StatementModel>? allStatement,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return StatementState(
      status: status ?? this.status,
      allStatement: allStatement ?? this.allStatement,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }
}
