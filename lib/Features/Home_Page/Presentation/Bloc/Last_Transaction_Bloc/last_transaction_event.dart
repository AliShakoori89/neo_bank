abstract class LastTransactionEvent {}

class FetchLastTransactionEvent extends LastTransactionEvent {
  final String depositNumber;

  FetchLastTransactionEvent({required this.depositNumber});
}
