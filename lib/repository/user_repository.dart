import 'dart:io';

import 'package:majestry_mobile_app/api/user_api.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/response/user_response.dart';

class UserRepository {
  Future<bool> registerUser(UserModel user) async {
    return await UserApi().registerUser(user);
  }

  Future<bool> loginUser(String email, String password) async {
    return await UserApi().loginUser(email, password);
  }

  Future<UserResponse?> getMe() async {
    return await UserApi().getMe();
  }

  Future<bool> updateProfile(UserModel user) async {
    return await UserApi().updateProfile(user);
  }

  Future<bool> updatePassword(String oldpassword, String newpassword) async {
    return await UserApi().updatePassword(oldpassword, newpassword);
  }

  Future<bool> updateProfilePic(File? file) async {
    return await UserApi().updateProfilePic(file);
  }
}
