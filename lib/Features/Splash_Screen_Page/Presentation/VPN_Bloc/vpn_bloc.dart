import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Services/vpn_checker_service.dart';
import 'vpn_event.dart';
import 'vpn_state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  Timer? _timer;

  VpnBloc() : super(VpnInitial()) {
    on<CheckVpnEvent>(_onCheckVpn);
    on<StartVpnMonitoringEvent>(_onStartMonitoring);
  }

  Future<void> _onCheckVpn(
      CheckVpnEvent event,
      Emitter<VpnState> emit,
      ) async {
    emit(VpnChecking());

    final isActive = await VpnCheckerService.isVpnActive();

    await Future.delayed(const Duration(milliseconds: 200)); // 👈 مهم

    if (isActive) {
      emit(VpnConnected(force: true));
    } else {
      emit(VpnDisconnected());
    }
  }

  void _onStartMonitoring(
      StartVpnMonitoringEvent event, Emitter<VpnState> emit) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      add(CheckVpnEvent());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
