import 'package:flutter/material.dart';

import 'package:majestry_mobile_app/model/cart_model.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
import 'package:majestry_mobile_app/response/cart_response.dart';
import 'package:majestry_mobile_app/screens/cart/bottom_model.dart';
import 'package:majestry_mobile_app/screens/cart/cart_card.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController(text: "1");
  List<CartModel>? lstcart;
  List<CartModel>? lstcart1;
  bool value = false;
  int? totalprice;
  int? totalpreparingtime;

  _deleteAllCart() async {
    bool isDeleted = await CartRepository().deleteallcart();
    if (isDeleted) {
      Navigator.pushNamed(context, "/foodsScreen");
      displaySuccessMessage(context, "Deleted Successfully");
    } else {
      displayErrorMessage(context, "Not Deleted");
    }
  }

  Future getCart() async {
    CartResponse? cart = await CartRepository().getCart();
    lstcart1 = cart?.data;
    setState(() {
      totalprice = lstcart1!
          .fold(
              0, (int sum, item) => sum + item.foodId!.price! * item.quantity!)
          .toInt();
      totalpreparingtime = lstcart1!
          .fold(
              0,
              (int sum, item) =>
                  sum + item.foodId!.preparingtime! * item.quantity!)
          .toInt();
    });
  }

  @override
  void initState() {
    // _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
    //   _proximityValue = event.proximity;

    //   if (_proximityValue <= 1) {
    //     Navigator.pushReplacementNamed(context, "/patientnavbar");
    //     return;
    //   }
    // }));
    getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/foodsScreen");
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[700],
        title: const Text("My Cart"),
        actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _deleteAllCart();
                    });
                  },
                  child: const Text(
                    "Delete All",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
          )
        ],
      ),
      body: FutureBuilder<CartResponse?>(
        future: CartRepository().getCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              lstcart = snapshot.data!.data!;

              return ListView.builder(
                itemCount: lstcart!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartCard(
                      id: lstcart![index].id,
                      foodpic: lstcart![index].foodId!.food_pic,
                      name: lstcart![index].foodId!.name,
                      preparingtime: lstcart![index].foodId!.preparingtime,
                      price: lstcart![index].foodId!.price,
                      quantity: lstcart![index].quantity);
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Total price: Rs. $totalprice",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return BottomModel(
                              orderItems: lstcart,
                              totalpreparingtime: totalpreparingtime,
                              totalprice: totalprice,
                              tablenumber: "1");
                        });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.done),
                      Text(
                        "Proceed to Payment",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
