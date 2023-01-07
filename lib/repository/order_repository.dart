import 'package:majestry_mobile_app/api/order_api.dart';

class OrderRepository {
  Future<bool> postOrder(orderItems, totalprice, totalpreparingtime,
      tablenumber, paymentmethod) async {
    return await OrderAPI().postOrder(
        orderItems, totalprice, totalpreparingtime, tablenumber, paymentmethod);
  }
}
