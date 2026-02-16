import 'package:equatable/equatable.dart';

abstract class VpnEvent extends Equatable {
  const VpnEvent();

  @override
  List<Object?> get props => [];
}

class CheckVpnEvent extends VpnEvent {}

class StartVpnMonitoringEvent extends VpnEvent {}
