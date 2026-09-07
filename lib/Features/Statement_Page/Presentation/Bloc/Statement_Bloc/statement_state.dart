import 'package:equatable/equatable.dart';

import '../../../Domain/Entities/statement_entity.dart';

enum StatementStateStatus { initial, success, error, loading }

extension UserLoginAuthStatusX on StatementStateStatus {
  bool get isInitial => this == StatementStateStatus.initial;
  bool get isSuccess => this == StatementStateStatus.success;
  bool get isError => this == StatementStateStatus.error;
  bool get isLoading => this == StatementStateStatus.loading;
}

class StatementState extends Equatable {
  const StatementState({required this.status, required this.allStatement, required this.isLoadingMore, required this.hasMore, required this.filteredStatement});

  static StatementState initial() =>
      StatementState(
          status: StatementStateStatus.initial,
          allStatement: [],
          filteredStatement: [],
          hasMore: true,
          isLoadingMore: false);

  final StatementStateStatus status;
  final List<StatementItemEntity> allStatement;
  final List<StatementItemEntity> filteredStatement;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [status, allStatement, filteredStatement, hasMore, isLoadingMore];

  StatementState copyWith({
    StatementStateStatus? status,
    List<StatementItemEntity>? allStatement,
    List<StatementItemEntity>? filteredStatement,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return StatementState(
      status: status ?? this.status,
      allStatement: allStatement ?? this.allStatement,
      filteredStatement: filteredStatement ?? this.filteredStatement,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }
}
