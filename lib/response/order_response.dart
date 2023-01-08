import 'package:json_annotation/json_annotation.dart';
import 'package:majestry_mobile_app/model/order_model.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  bool? success;
  List<OrderModel>? data;

  OrderResponse({
    this.success,
    this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
