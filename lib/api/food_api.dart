import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/response/fooditems_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class FoodAPI {
  Future<FooditemsResponse?> getFood() async {
    Future.delayed(const Duration(seconds: 2), () {});
    FooditemsResponse? foodResponse;

    try {
      Response response;
      var url = getFoodUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.get(url);
      if (response.statusCode == 200) {
        foodResponse = FooditemsResponse.fromJson(response.data);
      } else {
        foodResponse = null;
      }
    } catch (e) {
      debugPrint('Failed to get Food $e');
    }
    return foodResponse;
  }
}
