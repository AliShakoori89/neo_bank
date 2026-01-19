import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

enum GetAllCardsStatus { initial, success, error, loading, tokenExpired }

extension GetAllCardsStatusX on GetAllCardsStatus {
  bool get isInitial => this == GetAllCardsStatus.initial;
  bool get isSuccess => this == GetAllCardsStatus.success;
  bool get isError => this == GetAllCardsStatus.error;
  bool get isLoading => this == GetAllCardsStatus.loading;
}

class AllCardsState extends Equatable {
  const AllCardsState({required this.status, required this.cards});

  static AllCardsState initial() =>
      AllCardsState(status: GetAllCardsStatus.initial, cards: []);

  final GetAllCardsStatus status;
  final List<CardDataModel>? cards;

  @override
  List<Object?> get props => [status, cards];

  AllCardsState copyWith({
    GetAllCardsStatus? status,
    List<CardDataModel>? cards,
  }) {
    return AllCardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
    );
  }
}
