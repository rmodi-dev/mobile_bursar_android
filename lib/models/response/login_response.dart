class LoginResponse {
  final bool success;
  final String token;

  LoginResponse({
    required this.success,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      token: json['token'],
    );
  }

  factory LoginResponse.fromRawJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      token: json['token'],
    );
  }
}
