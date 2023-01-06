import 'package:flutter/material.dart';

import 'package:majestry_mobile_app/model/cart_model.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
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
  bool value = false;
  int? totalprice;

  final List<String> _paymentoption = [
    'Cash on Delivery',
    'Esewa',
    'Khalti',
  ]; // Option 2

  String? _paymentmethod; // Option 2

  _deleteAllCart() async {
    bool isDeleted = await CartRepository().deleteallcart();
    if (isDeleted) {
      Navigator.pushNamed(context, "/foodsScreen");
      displaySuccessMessage(context, "Deleted Successfully");
    } else {
      displayErrorMessage(context, "Not Deleted");
    }
  }

  // _postOrder(
  //     orderItems, totalprice, paymentmethod, phonenumber, address) async {
  //   bool isAdded = await OrderRepository()
  //       .postOrder(orderItems, totalprice, paymentmethod, phonenumber, address);
  //   if (isAdded) {
  //     Navigator.pushNamed(context, "/MyOrderScreen");
  //     displaySuccessMessage(context, "Ordered Successfully");
  //   } else {
  //     displayErrorMessage(context, "Not Ordered");
  //   }
  // }

  @override
  void initState() {
    // _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
    //   _proximityValue = event.proximity;

    //   if (_proximityValue <= 1) {
    //     Navigator.pushReplacementNamed(context, "/patientnavbar");
    //     return;
    //   }
    // }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lstcart = ModalRoute.of(context)!.settings.arguments as List<CartModel>;
    totalprice = lstcart!
        .fold(0, (int sum, item) => sum + item.foodId!.price! * item.quantity!)
        .toInt();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      appBar: AppBar(
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
      body: ListView.builder(
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
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      enabled: false,
                                      controller: _addressController,
                                      decoration: const InputDecoration(
                                        labelText: "Table Number",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButton(
                                      hint: _paymentmethod == null
                                          ? const Text('Select payment option')
                                          : Text(
                                              _paymentmethod!,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      items: _paymentoption.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? val) {
                                        setState(() {
                                          _paymentmethod = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                          onPressed: () {
                                            // setState(() {
                                            //   _postOrder(
                                            //       lstcart,
                                            //       totalprice,
                                            //       _paymentmethod,
                                            //       _phoneController.text,
                                            //       _addressController.text);
                                            // });
                                          },
                                          child: const Text("Order")),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
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
