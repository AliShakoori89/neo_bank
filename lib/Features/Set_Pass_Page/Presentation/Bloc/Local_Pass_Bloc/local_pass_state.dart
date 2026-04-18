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
  });

  static LocalPassState initial() => LocalPassState(
    status: LocalPassStatus.initial,
    isFirstLoginStatus: false,
  );

  final LocalPassStatus status;
  final bool isFirstLoginStatus;

  @override
  List<Object?> get props => [
    status,
    isFirstLoginStatus,
  ];

  LocalPassState copyWith({
    LocalPassStatus? status,
    bool? isFirstLoginStatus,
  }) {
    return LocalPassState(
      status: status ?? this.status,
      isFirstLoginStatus: isFirstLoginStatus ?? this.isFirstLoginStatus,
    );
  }
}