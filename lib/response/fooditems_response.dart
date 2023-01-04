import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/food_model.dart';
part 'fooditems_response.g.dart';

@JsonSerializable()
class FooditemsResponse {
  bool? success;
  List<FoodItems>? data;

  FooditemsResponse({
    this.success,
    this.data,
  });

  factory FooditemsResponse.fromJson(Map<String, dynamic> json) =>
      _$FooditemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FooditemsResponseToJson(this);
}
