import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/model/cart_model.dart';
import 'package:majestry_mobile_app/model/order_model.dart';
import 'package:majestry_mobile_app/repository/order_repository.dart';
import 'package:majestry_mobile_app/response/order_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "All Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: size.height * 0.76,
          child: FutureBuilder<OrderResponse?>(
            future: OrderRepository().getMyOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  List<OrderModel> lstorder = snapshot.data!.data!;
                  return ListView.builder(
                    itemCount: lstorder.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<CartModel> lstitems = lstorder[index].orderItems!;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: lstitems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: ListTile(
                                      tileColor: Colors.grey[300],
                                      leading: Image.network(
                                        "$baseUrl${lstitems[index].foodId!.food_pic}",
                                        height: 150,
                                      ),
                                      title: Text(
                                          "${lstitems[index].foodId!.name}"),
                                      subtitle: Text(
                                          "Quantity: ${lstitems[index].quantity}"),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                  "Order Status: ${lstorder[index].orderstatus}"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Payment Method: ${lstorder[index].paymentmethod}"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Table No: ${lstorder[index].tablenumber}"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Total Preparingtime: ${lstorder[index].totalpreparingtime} min"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total Price: Rs. ${lstorder[index].totalprice}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange[700]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              lstorder[index].orderstatus == "Pending"
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red[700]),
                                        ),
                                        onPressed: () {
                                          // setState(() {
                                          //   _cancelOrder(lstorder[index].id);
                                          // });
                                        },
                                        child: const Text("Cancel Order"),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
