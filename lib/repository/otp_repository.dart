import 'package:majestry_mobile_app/api/otp_api.dart';

class OtpRepository {
  Future<bool> sendEmail(String email) async {
    return await OtpApi().sendEmail(email);
  }

  Future<bool> resetPassword(
      String email, String otpcode, String password) async {
    return await OtpApi().resetPassword(email, otpcode, password);
  }
}
