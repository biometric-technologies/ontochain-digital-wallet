import 'package:ontochain_mobile_wallet/model/biometric_credential.dart';

class LoanApplication {
  final String id;
  final String offerId;
  final double amount;
  final String? deniedReason;
  final LoanApplicationStatus status;
  final dynamic meta;
  final DateTime createdAt;

  LoanApplication(
      {required this.id,
      required this.offerId,
      required this.amount,
      this.deniedReason,
      required this.status,
      required this.meta,
      required this.createdAt});

  factory LoanApplication.fromJson(Map<String, dynamic> json) =>
      LoanApplication(
          id: json['id'],
          offerId: json['offerId'],
          amount: json['amount'],
          status: LoanApplicationStatus.values
              .firstWhere((el) => el.name.toUpperCase() == json['status']),
          meta: json['meta'],
          createdAt: DateTime.parse(json['createdAt']));
}

enum LoanApplicationStatus { open, approved, denied }

class LoanApplicationForm {
  final String offerId;
  final String publicKey;
  final String firstName;
  final String lastName;
  final int age;
  final String phone;
  final String email;
  final List<BiometricCredential> credentials;
  final dynamic meta = {};

  LoanApplicationForm(
      {required this.offerId,
      required this.publicKey,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.phone,
      required this.email,
      required this.credentials});

  toJson() => {
        'offerId': offerId,
        'publicKey': publicKey,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'phone': phone,
        'email': email,
        'credentials': credentials.map((e) => e.toJson()).toList(),
        'meta': meta
      };
}
