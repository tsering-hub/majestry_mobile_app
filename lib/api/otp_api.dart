// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class OtpApi {
  Future<bool> sendEmail(String email) async {
    bool isSend = false;
    Response response;
    var url = otpsendUrl;
    var dio = HttpServices().getDioInstace();
    try {
      response = await dio.post(
        url,
        data: {"email": email},
      );
      if (response.statusCode == 200) {
        return isSend = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isSend;
  }
}
