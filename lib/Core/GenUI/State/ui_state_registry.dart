import 'package:injectable/injectable.dart';

@lazySingleton
class UiStateRegistry {
  final Set<String> _sources = {
    'balance',
    'hasBalance',
    'user_cards',
  };

  UiStateRegistry();

  bool contains(String source) {
    return _sources.contains(source);
  }
}