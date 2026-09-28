import 'package:equatable/equatable.dart';

import '../../../Domain/Entities/ali_card_pan_entity.dart';

enum AllCardsDetailStatus { initial, success, error, loading, tokenExpired }

extension AllCardsDetailStatusX on AllCardsDetailStatus {
  bool get isInitial => this == AllCardsDetailStatus.initial;
  bool get isSuccess => this == AllCardsDetailStatus.success;
  bool get isError => this == AllCardsDetailStatus.error;
  bool get isLoading => this == AllCardsDetailStatus.loading;
}

class AllCardsDetailState extends Equatable {
  const AllCardsDetailState({
    required this.status,
    this.cardsPan,
    this.cardsDeposit,
    this.cards,
  });

  static AllCardsDetailState initial() => AllCardsDetailState(
    status: AllCardsDetailStatus.initial,
    cardsPan: [],
    cardsDeposit: [],
    cards: [],
  );

  final AllCardsDetailStatus status;
  final List<String>? cardsPan;
  final List<String>? cardsDeposit;
  final List<AliCardPanEntity>? cards;

  @override
  List<Object?> get props => [status, cardsPan, cardsDeposit, cards];

  AllCardsDetailState copyWith({
    AllCardsDetailStatus? status,
    List<String>? cardsPan,
    List<String>? cardsDeposit,
    List<AliCardPanEntity>? cards,
  }) {
    return AllCardsDetailState(
      status: status ?? this.status,
      cardsPan: cardsPan ?? this.cardsPan,
      cardsDeposit: cardsDeposit ?? this.cardsDeposit,
      cards: cards ?? this.cards,
    );
  }
}
