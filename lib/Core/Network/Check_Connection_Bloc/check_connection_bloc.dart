import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Network/Check_Connection_Bloc/check_connection_event.dart';
import 'package:neo_bank_mehr_iran/Core/Network/Check_Connection_Bloc/check_connection_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityChangedEvent>((event, emit) {
      if (event.isOnline) {
        emit(ConnectivityOnline());
      } else {
        emit(ConnectivityOffline());
      }
    });
  }
}
