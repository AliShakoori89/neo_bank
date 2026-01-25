import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

enum GetAllCardsStatus {
  initial,
  success,
  error,
  loading,
  tokenExpired,
  refreshLimitExceeded,
}

extension GetAllCardsStatusX on GetAllCardsStatus {
  bool get isInitial => this == GetAllCardsStatus.initial;
  bool get isSuccess => this == GetAllCardsStatus.success;
  bool get isError => this == GetAllCardsStatus.error;
  bool get isLoading => this == GetAllCardsStatus.loading;
  bool get isTokenExpired => this == GetAllCardsStatus.tokenExpired;
  bool get isRefreshLimitExceeded =>
      this == GetAllCardsStatus.refreshLimitExceeded;
}

class AllCardsState extends Equatable {
  const AllCardsState({
    required this.status,
    required this.cards,
    required this.refreshCount,
  });

  static AllCardsState initial() => AllCardsState(
    status: GetAllCardsStatus.initial,
    cards: [],
    refreshCount: 0,
  );

  final GetAllCardsStatus status;
  final List<CardDataModel>? cards;
  final int refreshCount;

  @override
  List<Object?> get props => [status, cards, refreshCount];

  AllCardsState copyWith({
    GetAllCardsStatus? status,
    List<CardDataModel>? cards,
    int? refreshCount,
  }) {
    return AllCardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      refreshCount: refreshCount ?? this.refreshCount,
    );
  }
}
