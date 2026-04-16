class User {
  final String id;
  final String email;
  final String name;
  final String profession;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.profession,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profession: json['profession'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class AuthResponse {
  final User user;
  final String accessToken;
  final String tokenType;

  AuthResponse({
    required this.user,
    required this.accessToken,
    this.tokenType = 'bearer',
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'] ?? 'bearer',
    );
  }
}
