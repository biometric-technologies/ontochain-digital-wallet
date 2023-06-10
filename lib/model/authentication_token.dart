class AuthenticationToken {
  final String id;

  AuthenticationToken({required this.id});

  factory AuthenticationToken.fromJson(Map<String, dynamic> json) =>
      AuthenticationToken(id: json['token']);
}
