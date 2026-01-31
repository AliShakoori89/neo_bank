abstract class StatementEvent {
  List<Object> get props => [];
}

class GetLastestStatmentEvent extends StatementEvent {
  final String depositNumber;

  GetLastestStatmentEvent({required this.depositNumber});

  @override
  List<Object> get props => [depositNumber];
}
