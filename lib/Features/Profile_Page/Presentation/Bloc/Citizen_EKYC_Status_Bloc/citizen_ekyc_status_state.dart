import 'package:equatable/equatable.dart';

enum CitizenEkycStatusStateStatus { initial, success, error, loading }

extension CitizenEkycStatusX on CitizenEkycStatusStateStatus {
  bool get isInitial => this == CitizenEkycStatusStateStatus.initial;
  bool get isSuccess => this == CitizenEkycStatusStateStatus.success;
  bool get isError => this == CitizenEkycStatusStateStatus.error;
  bool get isLoading => this == CitizenEkycStatusStateStatus.loading;
}

class CitizenEkycStatusState extends Equatable {
  const CitizenEkycStatusState({required this.status, required this.citizenEkycStatus, required this.errorMessage});

  static CitizenEkycStatusState initial() =>
      CitizenEkycStatusState(
        status: CitizenEkycStatusStateStatus.initial,
        citizenEkycStatus: false,
        errorMessage: ''
      );

  final CitizenEkycStatusStateStatus status;
  final bool citizenEkycStatus;
  final String errorMessage;

  @override
  List<Object?> get props => [status, citizenEkycStatus, errorMessage];

  CitizenEkycStatusState copyWith({
    CitizenEkycStatusStateStatus? status,
    bool? citizenEkycStatus,
    String? errorMessage
  }) {
    return CitizenEkycStatusState(
      status: status ?? this.status,
      citizenEkycStatus: citizenEkycStatus ?? this.citizenEkycStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}