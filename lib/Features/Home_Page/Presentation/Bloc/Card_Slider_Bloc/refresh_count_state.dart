import 'package:equatable/equatable.dart';

enum RefreshCountStatus {
  initial,
  success,
  error,
  loading,
  refreshLimitExceeded,
}

extension GetAllCardsStatusX on RefreshCountStatus {
  bool get isInitial => this == RefreshCountStatus.initial;
  bool get isSuccess => this == RefreshCountStatus.success;
  bool get isError => this == RefreshCountStatus.error;
  bool get isLoading => this == RefreshCountStatus.loading;
  bool get isRefreshLimitExceeded =>
      this == RefreshCountStatus.refreshLimitExceeded;
}

class RefreshCountState extends Equatable {
  const RefreshCountState({required this.status, required this.refreshCount});

  static RefreshCountState initial() =>
      RefreshCountState(status: RefreshCountStatus.initial, refreshCount: 0);

  final RefreshCountStatus status;
  final int refreshCount;

  @override
  List<Object?> get props => [status, refreshCount];

  RefreshCountState copyWith({RefreshCountStatus? status, int? refreshCount}) {
    return RefreshCountState(
      status: status ?? this.status,
      refreshCount: refreshCount ?? this.refreshCount,
    );
  }
}
