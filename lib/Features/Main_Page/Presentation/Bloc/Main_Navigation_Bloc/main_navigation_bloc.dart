import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_navigation_event.dart';
import 'main_navigation_state.dart';

class MainNavigationBloc extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc({int initialIndex = 0}) : super(MainNavigationState(initialIndex)) {
    on<ChangeTabEvent>((event, emit) => emit(MainNavigationState(event.index)));
  }
}
