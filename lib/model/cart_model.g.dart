// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    id: json['_id'] as String?,
    foodId: json['foodId'] == null
        ? null
        : FoodItems.fromJson(json['foodId'] as Map<String, dynamic>),
    quantity: json['quantity'] as int?,
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      '_id': instance.id,
      'foodId': instance.foodId,
      'quantity': instance.quantity,
    };
