import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Core/Theme/app_them.dart';

enum ThemeEvent { toggle, load }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc(super.initialTheme) {
    on<ThemeEvent>(_onEvent);
  }

  Future<void> _onEvent(ThemeEvent event, Emitter<ThemeData> emit) async {
    final prefs = await SharedPreferences.getInstance();

    if (event == ThemeEvent.toggle) {
      final isDark = state.brightness == Brightness.light;
      await prefs.setBool('isDarkTheme', isDark);
      emit(isDark ? AppTheme.darkTheme : AppTheme.lightTheme);
    }
  }
}
