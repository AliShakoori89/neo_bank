import 'package:equatable/equatable.dart';

abstract class AbortTokenEvent extends Equatable {
  const AbortTokenEvent();

  @override
  List<Object?> get props => [];
}

class GetAbortTokenEvent extends AbortTokenEvent {}