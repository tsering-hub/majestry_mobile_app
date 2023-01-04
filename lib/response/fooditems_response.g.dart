// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fooditems_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooditemsResponse _$FooditemsResponseFromJson(Map<String, dynamic> json) {
  return FooditemsResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => FoodItems.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FooditemsResponseToJson(FooditemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
