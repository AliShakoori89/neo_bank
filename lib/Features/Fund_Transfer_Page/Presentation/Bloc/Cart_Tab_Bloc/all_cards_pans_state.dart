import 'package:equatable/equatable.dart';

enum AllCardsPanStatus { initial, success, error, loading, tokenExpired }

extension AllCardsPanStatusX on AllCardsPanStatus {
  bool get isInitial => this == AllCardsPanStatus.initial;
  bool get isSuccess => this == AllCardsPanStatus.success;
  bool get isError => this == AllCardsPanStatus.error;
  bool get isLoading => this == AllCardsPanStatus.loading;
}

class AllCardsPansState extends Equatable {
  const AllCardsPansState({required this.status, this.cardsPan});

  static AllCardsPansState initial() =>
      AllCardsPansState(status: AllCardsPanStatus.initial, cardsPan: ['----']);

  final AllCardsPanStatus status;
  final List<String>? cardsPan;

  @override
  List<Object?> get props => [status, cardsPan];

  AllCardsPansState copyWith({
    AllCardsPanStatus? status,
    List<String>? cardsPan,
  }) {
    return AllCardsPansState(
      status: status ?? this.status,
      cardsPan: cardsPan ?? this.cardsPan,
    );
  }
}
