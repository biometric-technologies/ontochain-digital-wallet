class User {
  final String id;
  final String publicKey;
  final int creditScore;
  final Map<String, dynamic> meta;


  User(
      {required this.id, required this.publicKey, required this.creditScore, required this.meta});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
          id: json['id'],
          publicKey: json['publicKey'],
          creditScore: json['creditScore'],
          meta: json['meta']
      );

}
