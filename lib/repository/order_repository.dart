import 'package:majestry_mobile_app/api/order_api.dart';
import 'package:majestry_mobile_app/response/order_response.dart';

class OrderRepository {
  Future<OrderResponse?> getMyOrder() async {
    return await OrderAPI().getMyOrder();
  }

  Future<bool> postOrder(orderItems, totalprice, totalpreparingtime,
      tablenumber, paymentmethod) async {
    return await OrderAPI().postOrder(
        orderItems, totalprice, totalpreparingtime, tablenumber, paymentmethod);
  }
}
