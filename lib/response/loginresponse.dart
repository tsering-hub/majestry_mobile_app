class LoginResponse {
  String? usertype;
  String? token;
  LoginResponse({this.usertype, this.token});

  //  converting json data to dart object
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        usertype: json["usertype"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() {
    return {
      "usertype": usertype,
      "token": token,
    };
  }
}
