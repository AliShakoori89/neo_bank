import 'package:equatable/equatable.dart';

import '../../../../Statement_Page/Data/Model/statement_model.dart';

enum SLastTransactionStatus { initial, success, error, loading }

extension SLastTransactionStatusX on SLastTransactionStatus {
  bool get isInitial => this == SLastTransactionStatus.initial;
  bool get isSuccess => this == SLastTransactionStatus.success;
  bool get isError => this == SLastTransactionStatus.error;
  bool get isLoading => this == SLastTransactionStatus.loading;
}

class LastTransactionState extends Equatable {
  const LastTransactionState({
    required this.status,
    required this.topStatement,
  });

  static LastTransactionState initial() => LastTransactionState(
    status: SLastTransactionStatus.initial,
    topStatement: [],
  );

  final SLastTransactionStatus status;
  final List<StatementModel> topStatement;

  @override
  List<Object?> get props => [status, topStatement];

  LastTransactionState copyWith({
    SLastTransactionStatus? status,
    List<StatementModel>? topStatement,
  }) {
    return LastTransactionState(
      status: status ?? this.status,
      topStatement: topStatement ?? this.topStatement,
    );
  }
}
