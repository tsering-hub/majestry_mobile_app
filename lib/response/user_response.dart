import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  bool? success;
  UserModel? data;

  UserResponse({
    this.success,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
