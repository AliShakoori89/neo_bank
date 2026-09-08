import 'package:equatable/equatable.dart';

import '../../../Data/Model/random_text_model.dart';

enum RandomTextStateStatus { initial, success, error, loading }

extension RandomTextStateStatusX on RandomTextStateStatus {
  bool get isInitial => this == RandomTextStateStatus.initial;
  bool get isSuccess => this == RandomTextStateStatus.success;
  bool get isError => this == RandomTextStateStatus.error;
  bool get isLoading => this == RandomTextStateStatus.loading;
}

class RandomTextState extends Equatable {
  const RandomTextState({
    required this.status,
    required this.randomText,
    required this.errorMessage,
  });

  static RandomTextState initial() => RandomTextState(
    status: RandomTextStateStatus.initial,
    randomText: RandomTextModel(),
    errorMessage: ''
  );

  final RandomTextStateStatus status;
  final RandomTextModel randomText;
  final String errorMessage;

  @override
  List<Object?> get props => [status, randomText, errorMessage];

  RandomTextState copyWith({
    RandomTextStateStatus? status,
    RandomTextModel? randomText,
    String? errorMessage
  }) {
    return RandomTextState(
      status: status ?? this.status,
      randomText: randomText ?? this.randomText,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
