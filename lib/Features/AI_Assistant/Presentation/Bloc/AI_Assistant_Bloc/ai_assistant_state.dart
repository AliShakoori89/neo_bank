import '../../../../../Core/GenUI/Models/ui_node_model.dart';

sealed class AiAssistantState {
  const AiAssistantState();
}

class AiAssistantInitial extends AiAssistantState {
  const AiAssistantInitial();
}

class AiAssistantLoading extends AiAssistantState {
  const AiAssistantLoading();
}

class AiAssistantUiSuccess extends AiAssistantState {
  final UiNode node;

  const AiAssistantUiSuccess({
    required this.node,
  });
}

class AiAssistantError extends AiAssistantState {
  final String message;

  const AiAssistantError({
    required this.message,
  });
}