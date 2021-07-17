class LoginResponse {
  final String token;
  final String error;

  LoginResponse({
    this.token,
    this.error,
  });

  factory LoginResponse.formJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequest {
  String email;
  String password;

  LoginRequest({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim()
    };

    return map;
  }
}
