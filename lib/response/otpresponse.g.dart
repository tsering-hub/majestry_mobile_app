// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otpresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponse _$OTPResponseFromJson(Map<String, dynamic> json) {
  return OTPResponse(
    success: json['success'] as bool?,
    data: json['data'] as String?,
  );
}

Map<String, dynamic> _$OTPResponseToJson(OTPResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
