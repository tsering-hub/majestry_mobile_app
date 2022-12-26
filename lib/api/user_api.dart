// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/response/loginresponse.dart';
import 'package:majestry_mobile_app/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
