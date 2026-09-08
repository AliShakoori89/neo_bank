class StatementEntity {
  final bool? hasMoreItem;
  final List<StatementItemEntity>? statements;

  StatementEntity({
    this.hasMoreItem,
    this.statements,
  });
}

class StatementItemEntity {
  final DateTime? date;
  final int? transferAmount;
  final String? actionDescription;
  final String? description;
  final String? referenceNumber;

  StatementItemEntity({
    this.date,
    this.transferAmount,
    this.actionDescription,
    this.description,
    this.referenceNumber,
  });
}