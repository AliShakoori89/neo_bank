import 'ui_state.dart';

class UiStateResolver {
  final UiState uiState;

  const UiStateResolver({
    required this.uiState,
  });

  dynamic resolve(String source) {
    return uiState.values[source];
  }
}