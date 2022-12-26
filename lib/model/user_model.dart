class UserModel {
  String? id;
  String? profilepic;
  String? username;
  String? name;
  String? email;
  String? password;
  String? contactno;
  String? dob;
  String? gender;
  String? userType;

  UserModel(
      {this.id,
      this.profilepic,
      this.username,
      this.name,
      this.email,
      this.password,
      this.contactno,
      this.dob,
      this.gender,
      this.userType});

  //  converting json data to dart object
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        contactno: json["contactno"],
        profilepic: json["profilepic"],
        dob: json["dob"],
        gender: json["gender"],
        userType: json["userType"],
      );

// coverting dart data to json data
  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "name": name,
        "password": password,
        "email": email,
        "contactno": contactno,
        "profilepic": profilepic,
        "gender": gender,
        "dob": dob,
        "userType": userType
      };
}
