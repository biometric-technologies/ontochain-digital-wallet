class LoanApplication {
  final String id;
  final String offerId;
  final double amount;
  final String? deniedReason;
  final String status;
  final Map<String, Object> meta;
  final DateTime createdAt;

  LoanApplication(
      {required this.id,
      required this.offerId,
      required this.amount,
      this.deniedReason,
      required this.status,
      required this.meta,
      required this.createdAt});
}
