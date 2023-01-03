import 'package:majestry_mobile_app/api/otp_api.dart';

class OtpRepository {
  Future<bool> sendEmail(String email) async {
    return await OtpApi().sendEmail(email);
  }
}
