class CardEntity {
  final String? depositNumber;
  final DateTime? expireDate;
  final String? pan;
  final String? cardDeposit;
  final int? availableBalance;

  CardEntity({
    this.depositNumber,
    this.expireDate,
    this.pan,
    this.cardDeposit,
    this.availableBalance,
  });
}