// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['_id'] as String?,
    orderItems: (json['orderItems'] as List<dynamic>?)
        ?.map((e) => CartModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalprice: json['totalprice'] as int?,
    totalpreparingtime: json['totalpreparingtime'] as int?,
    orderstatus: json['orderstatus'] as String?,
    paymentmethod: json['paymentmethod'] as String?,
    paymentstatus: json['paymentstatus'] as String?,
    tablenumber: json['tablenumber'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderItems': instance.orderItems,
      'totalprice': instance.totalprice,
      'totalpreparingtime': instance.totalpreparingtime,
      'orderstatus': instance.orderstatus,
      'paymentmethod': instance.paymentmethod,
      'paymentstatus': instance.paymentstatus,
      'tablenumber': instance.tablenumber,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
