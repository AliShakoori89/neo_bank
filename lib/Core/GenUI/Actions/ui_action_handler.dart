import 'package:injectable/injectable.dart';
import 'ui_action_registry.dart';

@lazySingleton
class UiActionHandler {
  final UiActionRegistry registry;

  const UiActionHandler({
    required this.registry,
  });

  Future<void> execute(
      String action,
      ) async {
    await registry.execute(action);
  }
}