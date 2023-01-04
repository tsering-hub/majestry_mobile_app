// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItems _$FoodItemsFromJson(Map<String, dynamic> json) {
  return FoodItems(
    id: json['_id'] as String?,
    food_pic: json['food_pic'] as String?,
    name: json['name'] as String?,
    desc: json['desc'] as String?,
    category: json['category'] as String?,
    preparingtime: json['preparingtime'] as int?,
    price: json['price'] as int?,
    stock: json['stock'] as int?,
  );
}

Map<String, dynamic> _$FoodItemsToJson(FoodItems instance) => <String, dynamic>{
      '_id': instance.id,
      'food_pic': instance.food_pic,
      'name': instance.name,
      'desc': instance.desc,
      'category': instance.category,
      'preparingtime': instance.preparingtime,
      'price': instance.price,
      'stock': instance.stock,
    };
