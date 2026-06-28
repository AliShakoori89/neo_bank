import 'package:equatable/equatable.dart';
import '../../../Data/Model/abort_token_model.dart';

enum AbortTokenStateStatus { initial, success, error, loading }

extension AbortTokenStateStatusX on AbortTokenStateStatus {
  bool get isInitial => this == AbortTokenStateStatus.initial;
  bool get isSuccess => this == AbortTokenStateStatus.success;
  bool get isError => this == AbortTokenStateStatus.error;
  bool get isLoading => this == AbortTokenStateStatus.loading;
}

class AbortTokenState extends Equatable {
  const AbortTokenState({
    required this.status,
    required this.abortToken,
  });

  static AbortTokenState initial() => AbortTokenState(
      status: AbortTokenStateStatus.initial,
    abortToken: AbortTokenModel(),
  );

  final AbortTokenStateStatus status;
  final AbortTokenModel abortToken;

  @override
  List<Object?> get props => [status, abortToken];

  AbortTokenState copyWith({
    AbortTokenStateStatus? status,
    AbortTokenModel? abortToken,
  }) {
    return AbortTokenState(
        status: status ?? this.status,
      abortToken: abortToken ?? this.abortToken,
    );
  }
}
