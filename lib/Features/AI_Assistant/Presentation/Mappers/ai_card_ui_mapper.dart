import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Entities/card_list_entity.dart';

import '../Models/ai_card_ui_model.dart';

class AiCardUiMapper {
  const AiCardUiMapper();

  List<AiCardUiModel> map(List<CardEntity> cards) {
    return cards.map(_mapCard).toList();
  }

  AiCardUiModel _mapCard(CardEntity card) {
    return AiCardUiModel(
      id: card.cardDeposit ?? card.depositNumber ?? '',
      title: _formatPan(card.pan),
      subtitle: card.depositNumber ?? '',
      balance: '${card.availableBalance ?? 0} تومان',
    );
  }

  String _formatPan(String? pan) {
    if (pan == null || pan.isEmpty) {
      return 'شماره کارت نامشخص';
    }

    if (pan.length != 16) {
      return pan;
    }

    return '${pan.substring(0, 4)} '
        '${pan.substring(4, 8)} '
        '${pan.substring(8, 12)} '
        '${pan.substring(12, 16)}';
  }
}