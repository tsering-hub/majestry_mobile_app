import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:majestry_mobile_app/model/cart_model.dart';
import 'package:majestry_mobile_app/model/food_model.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
import 'package:majestry_mobile_app/repository/food_repository.dart';
import 'package:majestry_mobile_app/response/cart_response.dart';
import 'package:majestry_mobile_app/response/fooditems_response.dart';
import 'package:majestry_mobile_app/screens/food/food_card.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({Key? key}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  String _searchQuery = "";
  final _searchController = TextEditingController();
  List<FoodItems>? lstFoods;
  List<CartModel>? lstcart;
  int? foodquantity;
  bool messageSuccess = false;
  List<String> litems = [
    "Starters",
    "Main Course",
    "Mo:mo",
    "Burger",
    "Thakali",
    "Pizza",
    "Salad",
    "Keema Noodle",
    "Fired Rice",
    "Neweri Khaja Set",
    "Thukpa",
    "Chowmein",
    "Cold Beverage",
    "Hot Beverage",
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/dashboardScreen");
            },
            icon: const Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange[700],
          title: const Text("Menu"),
          actions: [
            GestureDetector(
              onTap: () => {
                if (lstcart!.isNotEmpty)
                  {
                    Navigator.pushNamed(context, "/cartScreen",
                        arguments: lstcart)
                  }
              },
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      FontAwesomeIcons.cartShopping,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: FutureBuilder<CartResponse?>(
                      future: CartRepository().getCart(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            lstcart = snapshot.data!.data!;
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${lstcart!.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("No data"),
                            );
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 10),
            //     child: Text(
            //       "Your are in table number $tablenumber",
            //       textAlign: TextAlign.center,
            //       style: const TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
            // search bar
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  onChanged: (value) => {
                    setState(() {
                      _searchQuery = _searchController.text;
                    })
                  },
                  style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
                  controller: _searchController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search for food",
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),

            // const SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            //     child: Text(
            //       "Category",
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),

            // category section
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: litems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 222, 77, 77),
                              Color.fromARGB(255, 149, 101, 34)
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            litems[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            ),

            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 100,
            //     width: double.infinity,
            //     child: FutureBuilder<MedCategoryResponse?>(
            //       future: MedCategoryRepository().getMedCategory(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.done) {
            //           if (snapshot.hasData) {
            //             List<MedicineCategory> lstMedCategory =
            //                 snapshot.data!.data!;
            //             return ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: lstMedCategory.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Container(
            //                   margin: const EdgeInsets.symmetric(horizontal: 8),
            //                   width: 120,
            //                   decoration: const BoxDecoration(
            //                     gradient: LinearGradient(
            //                       colors: [iconbgcolor, textcolor],
            //                     ),
            //                   ),
            //                   child: Center(
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         const Icon(
            //                           FontAwesomeIcons.syringe,
            //                           size: 20,
            //                           color: Colors.white,
            //                         ),
            //                         const SizedBox(
            //                           height: 10,
            //                         ),
            //                         Text(
            //                           "${lstMedCategory[index].name}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 14, color: Colors.white),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //             );
            //           } else {
            //             return const Center(
            //               child: Text("No data"),
            //             );
            //           }
            //         } else if (snapshot.connectionState ==
            //             ConnectionState.waiting) {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         } else if (snapshot.hasError) {
            //           return Text("${snapshot.error}");
            //         } else {
            //           return const Center(
            //             child: CircularProgressIndicator(
            //               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
            // medicine section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<FooditemsResponse?>(
                  future: FoodRepository().getFood(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        List<FoodItems> lstAllFoods = snapshot.data!.data!;

                        if (_searchQuery != "") {
                          List<FoodItems> lstMedicinesFiltered = lstAllFoods
                              .where((v) =>
                                  v.name!.toLowerCase().contains(_searchQuery))
                              .toList();
                          lstFoods = lstMedicinesFiltered;
                        } else {
                          lstFoods = lstAllFoods;
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  mainAxisExtent: 300),
                          itemCount: lstFoods!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                key: ValueKey("lstFoods$index"),
                                onTap: () => {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   "/medicinescreen1",
                                      //   arguments: lstFoods![index],
                                      // )
                                    },
                                child: FoodCard(
                                  id: lstFoods![index].id,
                                  foodpic: lstFoods![index].food_pic,
                                  name: lstFoods![index].name,
                                  price: lstFoods![index].price,
                                  preparingtime: lstFoods![index].preparingtime,
                                ));
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No data"),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
