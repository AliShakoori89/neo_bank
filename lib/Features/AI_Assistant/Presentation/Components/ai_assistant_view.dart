import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Presentation/Components/type_writer_text.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import '../../../../Core/GenUI/Actions/ui_action_handler.dart';
import '../../../../Core/GenUI/Models/ui_node_model.dart';
import '../../../../Core/GenUI/Renderer/ui_renderer.dart';
import '../../../../Core/GenUI/State/ui_state_resolver.dart';
import '../../../Home_Page/Domain/Entities/card_list_entity.dart';
import '../../../Home_Page/Domain/UseCases/all_cards_use_case.dart';
import '../../../Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import '../Bloc/AI_Assistant_Bloc/ai_assistant_bloc.dart';
import '../Bloc/AI_Assistant_Bloc/ai_assistant_event.dart';
import '../Bloc/AI_Assistant_Bloc/ai_assistant_state.dart';
import '../Bloc/Account_Bloc/account_bloc.dart';
import '../Bloc/Account_Bloc/account_state.dart';
import '../State/ai_assistant_ui_state_mapper.dart';

class AiAssistantView extends StatefulWidget {

  final UiActionHandler actionHandler;
  final AllCardsUseCase allCardsUseCase;

  const AiAssistantView({
    super.key,
    required this.actionHandler,
    required this.allCardsUseCase,
  });

  @override
  State<AiAssistantView> createState() =>
      _AiAssistantViewState();
}

class _AiAssistantViewState extends State<AiAssistantView> {

  final TextEditingController promptController =
  TextEditingController();

  late Future<List<CardEntity>> _cardsFuture;

  @override
  void initState() {
    super.initState();

    _cardsFuture = widget.allCardsUseCase.getAllCards();
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'دستیار هوشمند',
        ),
      ),
      body: Column(
        children: [
          _buildPromptSection(),
          const Divider(),
          AppSpace.heightSpace_24,
          Expanded(
            child: _buildGeneratedUi(),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: promptController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'مثلاً موجودی حسابم را نمایش بده',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _generateUi,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  void _generateUi() {
    final prompt = promptController.text.trim();

    if (prompt.isEmpty) {
      return;
    }

    context.read<AiAssistantBloc>().add(
      GenerateUiEvent(
        prompt: prompt,
      ),
    );
  }

  Widget _buildGeneratedUi() {
    return BlocBuilder<AiAssistantBloc, AiAssistantState>(
      builder: (context, state) {
        return switch (state) {
          AiAssistantInitial() =>
              BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TypewriterText(text: ' روز بخیر ${state.userName}\n\n''سوال مورد نظر خود را بپرس تا کمکت کنم.'),
                  ],
                )

              );
            }
          ),

          AiAssistantLoading() =>
          const Center(
            child: CircularProgressIndicator(),
          ),

          AiAssistantError(:final message) =>
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    message,
                  ),
                ),
              ),

          AiAssistantUiSuccess(:final node) =>
              _renderNode(node),
        };
      },
    );
  }

  Widget _renderNode(UiNode node) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, accountState) {
        return FutureBuilder<List<CardEntity>>(
          future: _cardsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'خطا در دریافت کارت‌ها: ${snapshot.error}',
                ),
              );
            }

            final cards = snapshot.data ?? [];

            final uiState =
            const AiAssistantUiStateMapper().map(
              accountState: accountState,
              cards: cards,
            );

            final renderer = UiRenderer(
              actionHandler: widget.actionHandler,
              stateResolver: UiStateResolver(
                uiState: uiState,
              ),
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: renderer.render(node),
            );
          },
        );
      },
    );
  }}