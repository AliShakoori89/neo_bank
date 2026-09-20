import '../../../../Core/GenUI/State/ui_state.dart';
import '../Bloc/Account_Bloc/account_state.dart';

class AccountUiStateMapper {
  const AccountUiStateMapper();

  UiState map(AccountState state) {
    return switch (state) {
      AccountInitial() => const UiState(
        values: {
          'balance': 'برای مشاهده موجودی کلیک کنید',
          'hasBalance': false,
        },
      ),

      AccountLoading() => const UiState(
        values: {
          'balance': 'در حال دریافت موجودی...',
          'hasBalance': false,
        },
      ),

      AccountSuccess(:final balance) => UiState(
        values: {
          'balance': balance,
          'hasBalance': true,
        },
      ),

      AccountError(:final message) => UiState(
        values: {
          'balance': 'خطا: $message',
          'hasBalance': false,
        },
      ),
    };
  }
}