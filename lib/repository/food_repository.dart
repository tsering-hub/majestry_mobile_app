import 'package:majestry_mobile_app/api/food_api.dart';
import 'package:majestry_mobile_app/response/fooditems_response.dart';

class FoodRepository {
  Future<FooditemsResponse?> getFood() async {
    return await FoodAPI().getFood();
  }
}
