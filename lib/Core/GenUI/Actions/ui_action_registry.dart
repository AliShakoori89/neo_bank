import 'package:injectable/injectable.dart';
import 'ui_action.dart';

@lazySingleton
class UiActionRegistry {
  final Map<String, UiAction> _actions = {};

  void register(
      String name,
      UiAction action,
      ) {
    _actions[name] = action;
  }

  bool contains(String name) {
    return _actions.containsKey(name);
  }

  UiAction? get(String name) {
    return _actions[name];
  }

  Future<void> execute(
      String name,
      ) async {
    final action = _actions[name];

    if (action == null) {
      throw UnsupportedError(
        'Unsupported UI action: $name',
      );
    }

    await action();
  }
}