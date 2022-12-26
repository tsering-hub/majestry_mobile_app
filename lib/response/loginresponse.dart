class LoginResponse {
  String? token;
  LoginResponse({this.token});

  //  converting json data to dart object
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
