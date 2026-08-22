import 'package:equatable/equatable.dart';
import '../../../Data/Model/loan_model.dart';

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
    loan: <LoanModel>[],
  );

  final LoanPageStateStatus status;
  final List<LoanModel> loan;

  @override
  List<Object?> get props => [status, loan];

  LoanPageState copyWith({
    LoanPageStateStatus? status,
    List<LoanModel>? loan,
  }) {
    return LoanPageState(
      status: status ?? this.status,
      loan: loan ?? this.loan,
    );
  }
}