class Loan {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final double amount;
  final bool open;

  Loan({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.open,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      amount: json['amount'],
      open: json['open']);
}

