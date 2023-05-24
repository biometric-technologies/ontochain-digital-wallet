import 'dart:convert';

class Loan {
  final String id;
  final String startDate;
  final String endDate;
  final double sumUSD;
  final String status;

  Loan({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.sumUSD,
    required this.status,
  });

}