import 'package:injectable/injectable.dart';
import '../../../../Core/GenUI/Actions/ui_action_registry.dart';
import '../Bloc/Account_Bloc/account_bloc.dart';
import '../Bloc/Account_Bloc/account_event.dart';


@lazySingleton
class AiAssistantActionRegistry {
  final UiActionRegistry registry;
  final AccountBloc accountBloc;

  AiAssistantActionRegistry({
    required this.registry,
    required this.accountBloc,
  });

  void registerActions() {
    registry.register(
      'show_balance',
          () async {
            accountBloc.add(
              const GetBalanceEvent(),
            );
      },
    );

    registry.register(
      'transfer',
          () async {
        print(
          'Transfer action executed',
        );
      },
    );
  }
}