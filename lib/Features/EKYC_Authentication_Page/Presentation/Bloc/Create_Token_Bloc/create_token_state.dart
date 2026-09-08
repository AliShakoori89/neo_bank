import 'package:equatable/equatable.dart';

import '../../../Data/Model/create_token_model.dart';

enum CreateTokenStateStatus { initial, success, error, loading }

extension SLastTransactionStatusX on CreateTokenStateStatus {
  bool get isInitial => this == CreateTokenStateStatus.initial;
  bool get isSuccess => this == CreateTokenStateStatus.success;
  bool get isError => this == CreateTokenStateStatus.error;
  bool get isLoading => this == CreateTokenStateStatus.loading;
}

class CreateTokenState extends Equatable {
  const CreateTokenState({
    required this.status,
    required this.createTokenResponse,
    required this.errorMessage,
  });

  static CreateTokenState initial() => CreateTokenState(
    status: CreateTokenStateStatus.initial,
    createTokenResponse: CreateTokenModel(),
    errorMessage: ''
  );

  final CreateTokenStateStatus status;
  final CreateTokenModel createTokenResponse;
  final String errorMessage;

  @override
  List<Object?> get props => [status, createTokenResponse, errorMessage];

  CreateTokenState copyWith({
    CreateTokenStateStatus? status,
    CreateTokenModel? createTokenResponse,
    String? errorMessage
  }) {
    return CreateTokenState(
      status: status ?? this.status,
      createTokenResponse: createTokenResponse ?? this.createTokenResponse,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
