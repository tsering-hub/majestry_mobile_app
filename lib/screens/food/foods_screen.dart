import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/model/cart_model.dart';
import 'package:majestry_mobile_app/model/food_model.dart';
import 'package:majestry_mobile_app/repository/food_repository.dart';
import 'package:majestry_mobile_app/response/fooditems_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        appBar: AppBar(
          title: const Text("Menu"),
        ),
        body: CustomScrollView(
          slivers: [
            // search bar
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                onChanged: (value) => {
                  setState(() {
                    _searchQuery = _searchController.text;
                  })
                },
                style: const TextStyle(fontSize: 20, letterSpacing: 2.0),
                controller: _searchController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  suffix: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            )),

            // const SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            //     child: Text(
            //       "Category",
            //       style: TextStyle(
            //           fontSize: 25, fontWeight: FontWeight.w500, color: textcolor),
            //     ),
            //   ),
            // ),

            // category section
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
                                  mainAxisExtent: 220),
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
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(
                                          "$baseUrl${lstFoods![index].food_pic}",
                                          width: double.infinity,
                                          height: 120),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "${lstFoods![index].name}",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "Rs ${lstFoods![index].price}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange[700]),
                                        ),
                                      ),
                                    ],
                                  ),
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
