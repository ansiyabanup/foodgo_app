
class UserModel {
  final String email;
  final String accessToken;
  final String refreshToken;

  const UserModel({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] ?? '',
        accessToken: json['access'] ?? '',
        refreshToken: json['refresh'] ?? '',
      );
}
