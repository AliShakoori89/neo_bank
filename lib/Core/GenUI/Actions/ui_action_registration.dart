import '../../../Features/AI_Assistant/Domain/UseCases/get_balance_use_case.dart';
import 'ui_action_registry.dart';

void registerAiAssistantActions({
  required UiActionRegistry registry,
  required GetBalanceUseCase getBalanceUseCase,
}) {
  registry.register(
    'show_balance',
        () async {
      final balance = await getBalanceUseCase();

      print('Balance: $balance');
    },
  );

  registry.register(
    'transfer',
        () async {
      print('Starting transfer...');
    },
  );
}