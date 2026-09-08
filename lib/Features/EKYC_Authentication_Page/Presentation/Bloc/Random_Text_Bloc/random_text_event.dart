import 'package:equatable/equatable.dart';

abstract class RandomTextEvent extends Equatable {
  const RandomTextEvent();

  @override
  List<Object?> get props => [];
}

class GetRandomTextEvent extends RandomTextEvent {}