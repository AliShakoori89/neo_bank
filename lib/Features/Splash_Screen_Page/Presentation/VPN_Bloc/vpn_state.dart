import 'package:equatable/equatable.dart';

abstract class VpnState extends Equatable {
  const VpnState();

  @override
  List<Object?> get props => [];
}

class VpnInitial extends VpnState {}

class VpnChecking extends VpnState {}

class VpnDisconnected extends VpnState {}

class VpnConnected extends VpnState {
  final bool force;
  VpnConnected({this.force = false});
}
