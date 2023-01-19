import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/model/food_model.dart';
import 'package:majestry_mobile_app/repository/food_repository.dart';
import 'package:majestry_mobile_app/response/fooditems_response.dart';
import 'package:majestry_mobile_app/screens/home/cardfood.dart';
// ignore: depend_on_referenced_packages
import 'package:majestry_mobile_app/screens/home/food_page_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItems>? lstFoods;

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tsering Sherpa",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.biography.com/.image/t_share/MTQ3NTI2OTA4NzY5MjE2MTI4/drake_photo_by_prince_williams_wireimage_getty_479503454.jpg"),
                      radius: 25,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Top Orders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
              const FoodPageBody(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<FooditemsResponse?>(
                  future: FoodRepository().getFood(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        lstFoods = snapshot.data!.data!;

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
                                child: CardFood(
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
            ],
          ),
        ),
      ),
    );
  }
}
