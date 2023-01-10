import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/response/loginresponse.dart';
import 'package:majestry_mobile_app/response/user_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'httpservices.dart';
import 'package:http_parser/http_parser.dart';

class UserApi {
  _setDataToSharedPref(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('my_token', token);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> registerUser(UserModel user) async {
    bool isSignup = false;
    Response response;
    var url = registerUrl;
    var dio = HttpServices().getDioInstace();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return isSignup = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isSignup;
  }

  Future<bool> loginUser(String email, String password) async {
    bool isLogin = false;

    try {
      var url = loginUrl;
      var dio = HttpServices().getDioInstace();

      var response = await dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        token = loginResponse.token;
        usertype = loginResponse.usertype;

        if (token == null) {
          isLogin = false;
        } else {
          _setDataToSharedPref(token!);
          isLogin = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<UserResponse?> getMe() async {
    Future.delayed(const Duration(seconds: 0), () {});
    UserResponse? userResponse;

    try {
      Response response;
      var url = getMeUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.get(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 200) {
        userResponse = UserResponse.fromJson(response.data);
      } else {
        userResponse = null;
      }
    } catch (e) {
      debugPrint('Failed to get order $e');
    }
    return userResponse;
  }

  Future<bool> updateProfile(UserModel user) async {
    bool isUpdated = false;
    Response response;
    var url = updateProfileUrl;
    var dio = HttpServices().getDioInstace();
    try {
      response = await dio.put(url,
          data: user.toJson(),
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 201) {
        return isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }

  Future<bool> updatePassword(String oldpassword, String newpassword) async {
    bool isUpdated = false;
    Response response;
    var url = changepasswordUrl;
    var dio = HttpServices().getDioInstace();
    try {
      response = await dio.put(url,
          data: {
            "oldpassword": oldpassword,
            "newpassword": newpassword,
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 201) {
        return isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }

  Future<bool> updateProfilePic(File? file) async {
    try {
      var dio = HttpServices().getDioInstace();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);

        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        ); // image/jpeg -> jpeg
      }
      var url = updateProfilePicUrl;

      var formData = FormData.fromMap({"user_pic": image});

      var response = await dio.put(url,
          data: formData,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
          ));

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }
}
