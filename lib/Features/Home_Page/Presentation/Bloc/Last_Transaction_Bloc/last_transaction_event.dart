abstract class LastTransactionEvent {}

class FetchLastTransactionEvent extends LastTransactionEvent {
  final String depositNumber;
  final int? latestCount; // اگر null بود یعنی همه

  FetchLastTransactionEvent({required this.depositNumber, this.latestCount});
}
