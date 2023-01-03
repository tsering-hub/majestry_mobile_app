import 'package:json_annotation/json_annotation.dart';
part 'otpresponse.g.dart';

@JsonSerializable()
class OTPResponse {
  bool? success;
  String? data;

  OTPResponse({
    this.success,
    this.data,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);
}
