abstract class AiAssistantEvent {
  const AiAssistantEvent();
}

class GenerateUiEvent extends AiAssistantEvent {
  final String prompt;

  const GenerateUiEvent({
    required this.prompt,
  });
}

class GetBalanceEvent extends AiAssistantEvent {
  const GetBalanceEvent();
}