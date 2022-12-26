import 'package:majestry_mobile_app/api/user_api.dart';
import 'package:majestry_mobile_app/model/user_model.dart';

class UserRepository {
  Future<bool> registerUser(UserModel user) async {
    return await UserApi().registerUser(user);
  }

  Future<bool> patientlogin(String email, String password) async {
    return await UserApi().loginUser(email, password);
  }
}
