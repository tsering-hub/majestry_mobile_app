import 'package:majestry_mobile_app/api/order_api.dart';
import 'package:majestry_mobile_app/response/order_response.dart';

class OrderRepository {
  Future<OrderResponse?> getMyPendingOrder() async {
    return await OrderAPI().getMyPendingOrder();
  }

  Future<bool> postOrder(orderItems, totalprice, totalpreparingtime,
      tablenumber, paymentmethod) async {
    return await OrderAPI().postOrder(
        orderItems, totalprice, totalpreparingtime, tablenumber, paymentmethod);
  }
}
