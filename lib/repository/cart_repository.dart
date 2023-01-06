import 'package:majestry_mobile_app/api/cart_api.dart';
import 'package:majestry_mobile_app/response/cart_response.dart';

class CartRepository {
  Future<CartResponse?> getCart() async {
    return await CartAPI().getCart();
  }

  Future<bool> addtocart(foodId, int? quantity) async {
    return await CartAPI().addtocart(foodId, quantity);
  }

  Future<bool> deleteallcart() async {
    return await CartAPI().deleteallcart();
  }
}
