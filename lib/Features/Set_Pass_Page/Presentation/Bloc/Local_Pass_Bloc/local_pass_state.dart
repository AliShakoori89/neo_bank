import 'package:equatable/equatable.dart';

enum LocalPassStatus { initial, success, error, loading }

extension LocalPassStatusX on LocalPassStatus {
  bool get isInitial => this == LocalPassStatus.initial;
  bool get isSuccess => this == LocalPassStatus.success;
  bool get isError => this == LocalPassStatus.error;
  bool get isLoading => this == LocalPassStatus.loading;
}

class LocalPassState extends Equatable {
  const LocalPassState({
    required this.status,
    required this.isFirstLoginStatus,
    required this.localPass
  });

  static LocalPassState initial() => LocalPassState(
    status: LocalPassStatus.initial,
    isFirstLoginStatus: false,
    localPass: ''
  );

  final LocalPassStatus status;
  final bool isFirstLoginStatus;
  final String localPass;

  @override
  List<Object?> get props => [
    status,
    isFirstLoginStatus,
    localPass
  ];

  LocalPassState copyWith({
    LocalPassStatus? status,
    bool? isFirstLoginStatus,
    String? localPass
  }) {
    return LocalPassState(
      status: status ?? this.status,
      isFirstLoginStatus: isFirstLoginStatus ?? this.isFirstLoginStatus,
      localPass: localPass ?? this.localPass
    );
  }
}