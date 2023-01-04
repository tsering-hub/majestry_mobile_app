// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/food_model.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: '_id')
  String? id;
  FoodItems? foodId;
  int? quantity;

  CartModel({
    this.id,
    this.foodId,
    this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
