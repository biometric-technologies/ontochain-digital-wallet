import 'package:intl/intl.dart';

class BiometricCredential {
  final List<String> context;
  final String id;
  final List<String> type;
  final String issuer;
  final DateTime issuanceDate;
  final CredentialSubject credentialSubject;
  final Proof proof;

  BiometricCredential(
      {required this.context,
      required this.id,
      required this.type,
      required this.issuer,
      required this.issuanceDate,
      required this.credentialSubject,
      required this.proof});

  factory BiometricCredential.fromJson(Map<String, dynamic> json) =>
      BiometricCredential(
        context: (json['@context'] as List<dynamic>).cast<String>(),
        id: json['id'],
        type: (json['type'] as List<dynamic>).cast<String>(),
        issuer: json['issuer'],
        issuanceDate: DateTime.parse(json['issuanceDate']),
        credentialSubject:
            CredentialSubject.fromJson(json['credentialSubject']),
        proof: Proof.fromJson(json['proof']),
      );

  Map<String, dynamic> toJson() => {
        '@context': context,
        'id': id,
        'type': type,
        'issuer': issuer,
        'issuanceDate':
            DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(issuanceDate),
        'credentialSubject': credentialSubject.toJson(),
        'proof': proof.toJson(),
      };
}

class CredentialSubject {
  final String id;
  final String biometrics;

  CredentialSubject({required this.id, required this.biometrics});

  factory CredentialSubject.fromJson(Map<String, dynamic> json) {
    return CredentialSubject(
      id: json['id'],
      biometrics: json['biometrics'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'biometrics': biometrics,
      };
}

class Proof {
  final String type;
  final String created;
  final String proofPurpose;
  final String verificationMethod;
  final String jwt;

  Proof(
      {required this.type,
      required this.created,
      required this.proofPurpose,
      required this.verificationMethod,
      required this.jwt});

  factory Proof.fromJson(Map<String, dynamic> json) {
    return Proof(
        type: json['type'],
        created: json['created'],
        proofPurpose: json['proofPurpose'],
        verificationMethod: json['verificationMethod'],
        jwt: json['jwt']);
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'created': created,
        'proofPurpose': proofPurpose,
        'verificationMethod': verificationMethod,
        'jwt': jwt,
      };
}
