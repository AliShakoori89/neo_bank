import 'package:equatable/equatable.dart';
import '../../../Data/Model/create_token_model.dart';
import '../../../Data/Model/validate_token_model.dart';

enum ValidateTokenStateStatus { initial, success, error, loading }

extension ValidateTokenStatusX on ValidateTokenStateStatus {
  bool get isInitial => this == ValidateTokenStateStatus.initial;
  bool get isSuccess => this == ValidateTokenStateStatus.success;
  bool get isError => this == ValidateTokenStateStatus.error;
  bool get isLoading => this == ValidateTokenStateStatus.loading;
}

class ValidateTokenState extends Equatable {
  const ValidateTokenState({
    required this.status,
    required this.validateTokenResponse,
    required this.errorMessage,
  });

  static ValidateTokenState initial() => ValidateTokenState(
    status: ValidateTokenStateStatus.initial,
      validateTokenResponse: ValidateTokenModel(),
    errorMessage: ''
  );

  final ValidateTokenStateStatus status;
  final ValidateTokenModel validateTokenResponse;
  final String errorMessage;

  @override
  List<Object?> get props => [status, validateTokenResponse, errorMessage];

  ValidateTokenState copyWith({
    ValidateTokenStateStatus? status,
    ValidateTokenModel? validateTokenResponse,
    String? errorMessage
  }) {
    return ValidateTokenState(
      status: status ?? this.status,
      validateTokenResponse: validateTokenResponse ?? this.validateTokenResponse,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
