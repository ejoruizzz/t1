class User {
  final String email;
  final String name;
  final String accessToken;
  final int expiresIn;
  final String refreshToken;

  User({
    required this.email,
    required this.name,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      accessToken: json['accessToken'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
    };
  }
}