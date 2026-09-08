import 'package:equatable/equatable.dart';

class LoanEntity extends Equatable {
  final String? loanNumber;
  final String? title;
  final String? description;
  final int? amount;
  final int? loanStatus;
  final String? loanStatusDescription;
  final List<InstallmentEntity>? installments;

  const LoanEntity({
    this.loanNumber,
    this.title,
    this.description,
    this.amount,
    this.loanStatus,
    this.loanStatusDescription,
    this.installments,
  });

  factory LoanEntity.fromJson(Map<String, dynamic> json) {
    return LoanEntity(
      loanNumber: json['loanNumber'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      loanStatus: json['loanStatus'] as int? ?? 0,
      loanStatusDescription:
      json['loanStatusDescription'] as String? ?? '',
      installments: (json['installments'] as List? ?? [])
          .map(
            (item) => InstallmentEntity.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loanNumber': loanNumber,
      'title': title,
      'description': description,
      'amount': amount,
      'loanStatus': loanStatus,
      'loanStatusDescription': loanStatusDescription,
      'installments': installments!
          .map((item) => item.toJson())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [
    loanNumber,
    title,
    description,
    amount,
    loanStatus,
    loanStatusDescription,
    installments,
  ];
}

class InstallmentEntity extends Equatable {
  final int installmentNo;
  final DateTime dueDate;
  final int amount;
  final int status;
  final String statusDescription;

  const InstallmentEntity({
    required this.installmentNo,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.statusDescription,
  });

  factory InstallmentEntity.fromJson(Map<String, dynamic> json) {
    return InstallmentEntity(
      installmentNo: json['installmentNo'] as int? ?? 0,
      dueDate: DateTime.parse(
        json['dueDate'] as String,
      ),
      amount: json['amount'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      statusDescription:
      json['statusDescription'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installmentNo': installmentNo,
      'dueDate': dueDate.toIso8601String(),
      'amount': amount,
      'status': status,
      'statusDescription': statusDescription,
    };
  }

  @override
  List<Object?> get props => [
    installmentNo,
    dueDate,
    amount,
    status,
    statusDescription,
  ];
}