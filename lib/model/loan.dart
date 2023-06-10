class Loan {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final double sumUSD;
  final LoanStatus status;

  Loan({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.sumUSD,
    required this.status,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      sumUSD: double.parse(json['sumUSD']),
      status: LoanStatus.values
          .firstWhere((e) => e.name.toUpperCase() == json['status']));
}

enum LoanStatus { open, closed }
