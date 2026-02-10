abstract class StatementEvent {}

class FetchStatementEvent extends StatementEvent {
  final String depositNumber;

  FetchStatementEvent({required this.depositNumber});
}

class FetchFilterStatementEvent extends StatementEvent {
  final String depositNumber;
  int? statementActionType;
  final String startDate;
  final String endDate;

  FetchFilterStatementEvent({required this.depositNumber, this.statementActionType, required this.startDate, required this.endDate});
}

class LoadMoreStatementEvent extends StatementEvent {
  final String depositNumber;
  LoadMoreStatementEvent(this.depositNumber);
}

class LoadMoreFilteredStatementEvent extends StatementEvent {
  final String depositNumber;
  int? statementActionType;
  final String startDate;
  final String endDate;
  LoadMoreFilteredStatementEvent(this.depositNumber, this.statementActionType, this.startDate, this.endDate);
}
