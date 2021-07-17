class RegisterResponse {
  // final int id;
  // final String token;
  // final String error;
  final String isLogined;

  RegisterResponse({
    // this.id,
    // this.token,
    // this.error,
    this.isLogined,
  });

  factory RegisterResponse.formJson(Map<String, dynamic> json) {
    return RegisterResponse(
      // id: json["id"] != null ? json["id"] : 0,
      // token: json["token"] != null ? json["token"] : "",
      // error: json["error"] != null ? json["error"] : "",
      isLogined: json["isLogined"] != null ? json["isLogined"] : "true",
    );
  }
}

class RegisterRequest {
  String email;
  String password;
  RegisterRequest({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "Email": email.trim(),
      "Password": password.trim(),
    };
    return map;
  }
  
}
