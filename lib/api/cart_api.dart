import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/response/cart_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class CartAPI {
  Future<CartResponse?> getCart() async {
    Future.delayed(const Duration(seconds: 2), () {});
    CartResponse? cartResponse;

    try {
      Response response;
      var url = getCartUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.get(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 200) {
        cartResponse = CartResponse.fromJson(response.data);
      } else {
        cartResponse = null;
      }
    } catch (e) {
      debugPrint('Failed to get Cart $e');
    }
    return cartResponse;
  }

  Future<bool> addtocart(foodId, int? quantity) async {
    bool isAdded = false;

    try {
      Response response;
      var url = addtocartUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.post(url,
          data: {
            "foodId": foodId,
            "quantity": quantity,
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 201) {
        return isAdded = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isAdded;
  }

  Future<bool> deletecart(id) async {
    bool isDeleted = false;

    try {
      Response response;
      var url = deleteacartUrl + id;
      var dio = HttpServices().getDioInstace();
      response = await dio.delete(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 200) {
        return isDeleted = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isDeleted;
  }

  Future<bool> deleteallcart() async {
    bool isDeleted = false;

    try {
      Response response;
      var url = deleteallcartUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.delete(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 200) {
        return isDeleted = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isDeleted;
  }
}
