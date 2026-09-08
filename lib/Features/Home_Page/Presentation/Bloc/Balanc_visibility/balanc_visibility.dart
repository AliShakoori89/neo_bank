import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceVisibilityCubit extends Cubit<bool> {
  static const _key = 'balance_visible';

  BalanceVisibilityCubit() : super(true) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_key);
    if (saved != null) {
      emit(saved);
    }
  }

  Future<void> toggle() async {
    final newValue = !state;
    emit(newValue);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, newValue);
  }
}
