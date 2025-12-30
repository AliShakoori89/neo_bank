import 'package:equatable/equatable.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/card_list_model.dart';

enum GetAllCardsStatus { initial, success, error, loading, tokenExpired }

extension GetAllCardsStatusX on GetAllCardsStatus {
  bool get isInitial => this == GetAllCardsStatus.initial;
  bool get isSuccess => this == GetAllCardsStatus.success;
  bool get isError => this == GetAllCardsStatus.error;
  bool get isLoading => this == GetAllCardsStatus.loading;
  bool get isTokenExpired => this == GetAllCardsStatus.tokenExpired;
}

class GetAllCardsState extends Equatable {
  const GetAllCardsState({required this.status, required this.cards});

  static GetAllCardsState initial() =>
      GetAllCardsState(status: GetAllCardsStatus.initial, cards: []);

  final GetAllCardsStatus status;
  final List<CardDataModel>? cards;

  @override
  List<Object?> get props => [status, cards];

  GetAllCardsState copyWith({
    GetAllCardsStatus? status,
    List<CardDataModel>? cards,
  }) {
    return GetAllCardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
    );
  }
}
