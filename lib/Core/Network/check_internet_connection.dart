import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit() : super(ConnectivityStatus.online);

  void update(bool isOnline) {
    emit(isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline);
  }
}