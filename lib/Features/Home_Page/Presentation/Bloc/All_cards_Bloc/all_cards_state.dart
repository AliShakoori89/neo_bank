import 'package:equatable/equatable.dart';
import '../../../Domain/Entities/card_list_entity.dart';

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
}

class AllCardsState extends Equatable {
  const AllCardsState({required this.status, required this.cards});

  static AllCardsState initial() =>
      AllCardsState(status: GetAllCardsStatus.initial, cards: []);

  final GetAllCardsStatus status;
  final List<CardEntity>? cards;

  @override
  List<Object?> get props => [status, cards];

  AllCardsState copyWith({
    GetAllCardsStatus? status,
    List<CardEntity>? cards,
  }) {
    return AllCardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
    );
  }
}
