// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'food_model.g.dart';

@JsonSerializable()
class FoodItems {
  @JsonKey(name: '_id')
  String? id;
  String? food_pic;
  String? name;
  String? desc;
  String? category;
  int? preparingtime;
  int? price;
  int? stock;

  FoodItems(
      {this.id,
      this.food_pic,
      this.name,
      this.desc,
      this.category,
      this.preparingtime,
      this.price,
      this.stock});

  factory FoodItems.fromJson(Map<String, dynamic> json) =>
      _$FoodItemsFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemsToJson(this);
}
