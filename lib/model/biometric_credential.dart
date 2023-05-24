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
}

class CredentialSubject {
  final String id;
  final String biometrics;

  CredentialSubject({required this.id, required this.biometrics});
}

class Proof {
  final String type;
  final String created;
  final String proofPurpose;
  final String verificationMethod;
  final String jws;

  Proof(
      {required this.type,
      required this.created,
      required this.proofPurpose,
      required this.verificationMethod,
      required this.jws});
}

class Credential {
  final String photoBase64;
  final String issuer;
  final DateTime issuanceDate;
  final List<String> type = ['VerifiableCredential', 'BiometricCredential'];
  final verified = true;

  Credential(
      {required this.photoBase64,
      required this.issuer,
      required this.issuanceDate});
}
