import 'package:equatable/equatable.dart';
import '../../../Domain/Entities/loan_entity.dart';

enum LoanPageStateStatus { initial, success, error, loading }

extension LoanPageStateStatusX on LoanPageStateStatus {
  bool get isInitial => this == LoanPageStateStatus.initial;
  bool get isSuccess => this == LoanPageStateStatus.success;
  bool get isError => this == LoanPageStateStatus.error;
  bool get isLoading => this == LoanPageStateStatus.loading;
}

class LoanPageState extends Equatable {
  const LoanPageState({
    required this.status,
    required this.loan,
  });

  static LoanPageState initial() => LoanPageState(
    status: LoanPageStateStatus.initial,
    loan: <LoanEntity>[],
  );

  final LoanPageStateStatus status;
  final List<LoanEntity> loan;

  @override
  List<Object?> get props => [status, loan];

  LoanPageState copyWith({
    LoanPageStateStatus? status,
    List<LoanEntity>? loan,
  }) {
    return LoanPageState(
      status: status ?? this.status,
      loan: loan ?? this.loan,
    );
  }
}