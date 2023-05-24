class LoanOffer {
  final String id;
  final String name;
  final double amount;
  final int days;
  final Map<String, Object> meta;
  final DateTime createdAt;

  LoanOffer(
      {required this.id,
      required this.name,
      required this.amount,
      required this.days,
      required this.meta,
      required this.createdAt});
}
