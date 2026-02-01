abstract class StatementEvent {}

class FetchStatementEvent extends StatementEvent {
  final String depositNumber;
  final int? latestCount; // اگر null بود یعنی همه

  FetchStatementEvent({required this.depositNumber, this.latestCount});
}
