import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/cart_model.dart';
part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  bool? success;
  List<CartModel>? data;

  CartResponse({
    this.success,
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
