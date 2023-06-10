class LoanOffer {
  final String id;
  final String name;
  final double amount;
  final int days;
  final Map<String, dynamic> meta;
  final DateTime createdAt;

  LoanOffer(
      {required this.id,
      required this.name,
      required this.amount,
      required this.days,
      required this.meta,
      required this.createdAt});

  factory LoanOffer.fromJson(Map<String, dynamic> json) => LoanOffer(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      days: json['days'],
      meta: json['meta'],
      createdAt: DateTime.parse(json['createdAt']));
}
