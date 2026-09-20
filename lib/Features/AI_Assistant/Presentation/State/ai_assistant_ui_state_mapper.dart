import 'package:neo_bank_mehr_iran/Core/GenUI/State/ui_state.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Entities/card_list_entity.dart';

import '../Bloc/Account_Bloc/account_state.dart';

class AiAssistantUiStateMapper {
  const AiAssistantUiStateMapper();

  UiState map({
    required AccountState accountState,
    required List<CardEntity> cards,
  }) {
    final values = <String, dynamic>{
      'user_cards': cards.map((card) {
        return {
          'id': card.cardDeposit ?? card.depositNumber ?? '',
          'pan': _formatPan(card.pan),
          'depositNumber': card.depositNumber ?? '',
          'balance': card.availableBalance ?? 0,
        };
      }).toList(),
    };

    switch (accountState) {
      case AccountInitial():
        values.addAll({
          'balance': 'برای مشاهده موجودی کلیک کنید',
          'hasBalance': false,
        });

      case AccountLoading():
        values.addAll({
          'balance': 'در حال دریافت موجودی...',
          'hasBalance': false,
        });

      case AccountSuccess(:final balance):
        values.addAll({'balance': balance, 'hasBalance': true});

      case AccountError(:final message):
        values.addAll({'balance': 'خطا: $message', 'hasBalance': false});
    }

    return UiState(values: values);
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
