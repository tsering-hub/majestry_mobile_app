import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/api/httpservices.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class OrderAPI {
  // Future<OrderResponse?> getMyOrder() async {
  //   Future.delayed(const Duration(seconds: 0), () {});
  //   OrderResponse? orderResponse;

  //   try {
  //     Response response;
  //     var url = getMyOrderUrl;
  //     var dio = HttpServices().getDioInstace();
  //     response = await dio.get(url,
  //         options: Options(
  //             headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
  //     if (response.statusCode == 201) {
  //       orderResponse = OrderResponse.fromJson(response.data);
  //     } else {
  //       orderResponse = null;
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to get order $e');
  //   }
  //   return orderResponse;
  // }

  Future<bool> postOrder(orderItems, totalprice, totalpreparingtime,
      tablenumber, paymentmethod) async {
    bool isAdded = false;
    String? paymentstatus;
    if (paymentmethod == "Pay Cash") {
      paymentstatus = "Pending";
    } else {
      paymentstatus = "Paid";
    }
    try {
      Response response;
      var url = baseUrl + postOrderUrl;
      var dio = HttpServices().getDioInstace();
      response = await dio.post(url,
          data: {
            "orderItems": orderItems,
            "totalprice": totalprice,
            "totalpreparingtime": totalpreparingtime,
            "paymentmethod": paymentmethod,
            "paymentstatus": paymentstatus,
            "tablenumber": tablenumber
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

  // Future<bool> cancelOrder(id) async {
  //   bool isCancel = false;

  //   try {
  //     Response response;
  //     var url = baseUrl + cancelOrderUrl;
  //     var dio = HttpServices().getDioInstace();
  //     response = await dio.put(url,
  //         data: {"id": id},
  //         options: Options(
  //             headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
  //     if (response.statusCode == 201) {
  //       return isCancel = true;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return isCancel;
  // }
}
