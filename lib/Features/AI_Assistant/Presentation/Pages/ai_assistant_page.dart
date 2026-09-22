import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../Core/DI/injection_container.dart';
import '../../../../Core/GenUI/Actions/ui_action_handler.dart';
import '../../../Home_Page/Domain/UseCases/all_cards_use_case.dart';
import '../Actions/ai_assistant_action_registry.dart';
import '../Bloc/Account_Bloc/account_bloc.dart';
import '../Components/ai_assistant_view.dart';

class AiAssistantPage extends StatelessWidget {
  const AiAssistantPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final actionRegistry = sl<AiAssistantActionRegistry>();
    final accountBloc = context.read<AccountBloc>();

    actionRegistry.registerActions(accountBloc);


    return AiAssistantView(
      actionHandler: GetIt.I<UiActionHandler>(),
      allCardsUseCase: GetIt.I<AllCardsUseCase>(),
    );
  }
}