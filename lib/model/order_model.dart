// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/cart_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id')
  String? id;
  List<CartModel>? orderItems;
  int? totalprice;
  int? totalpreparingtime;
  String? orderstatus;
  String? paymentmethod;
  String? paymentstatus;
  String? tablenumber;
  DateTime? createdAt;

  OrderModel({
    this.id,
    this.orderItems,
    this.totalprice,
    this.totalpreparingtime,
    this.orderstatus,
    this.paymentmethod,
    this.paymentstatus,
    this.tablenumber,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
