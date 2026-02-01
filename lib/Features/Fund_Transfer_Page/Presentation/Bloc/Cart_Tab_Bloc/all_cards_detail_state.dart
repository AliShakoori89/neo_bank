import 'package:equatable/equatable.dart';

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
  });

  static AllCardsDetailState initial() => AllCardsDetailState(
    status: AllCardsDetailStatus.initial,
    cardsPan: ['----'],
    cardsDeposit: ['----'],
  );

  final AllCardsDetailStatus status;
  final List<String>? cardsPan;
  final List<String>? cardsDeposit;

  @override
  List<Object?> get props => [status, cardsPan, cardsDeposit];

  AllCardsDetailState copyWith({
    AllCardsDetailStatus? status,
    List<String>? cardsPan,
    List<String>? cardsDeposit,
  }) {
    return AllCardsDetailState(
      status: status ?? this.status,
      cardsPan: cardsPan ?? this.cardsPan,
      cardsDeposit: cardsDeposit ?? this.cardsDeposit,
    );
  }
}
