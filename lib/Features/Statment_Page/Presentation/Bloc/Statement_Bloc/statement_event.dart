abstract class StatementEvent {}

class FetchStatementEvent extends StatementEvent {
  final String depositNumber;

  FetchStatementEvent({required this.depositNumber});
}

class LoadMoreStatementEvent extends StatementEvent {
  final String depositNumber;
  LoadMoreStatementEvent(this.depositNumber);
}
