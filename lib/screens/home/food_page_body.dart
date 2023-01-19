import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/model/toporder_model.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  List<TopOrderModel>? lsttoporder = [
    TopOrderModel(
        name: "Burger",
        foodpic:
            "https://www.seriouseats.com/thmb/e16lLOoVEix_JZTv7iNyAuWkPn8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2014__09__20140918-jamie-olivers-comfort-food-insanity-burger-david-loftus-f7d9042bdc2a468fbbd50b10d467dafd.jpg",
        rating: 5,
        comment: 13),
    TopOrderModel(
        name: "Pizza",
        foodpic:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/800px-Eq_it-na_pizza-margherita_sep2005_sml.jpg",
        rating: 5,
        comment: 13),
    TopOrderModel(
        name: "Momo",
        foodpic:
            "https://static8.depositphotos.com/1039098/1040/i/600/depositphotos_10403844-stock-photo-vegetarian-nepalese-momo.jpg",
        rating: 5,
        comment: 13),
    TopOrderModel(
        name: "Thakali",
        foodpic: "https://m.recipes.timesofindia.com/photo/82048030.cms",
        rating: 5,
        comment: 13)
  ];

  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: lsttoporder!.length,
          itemBuilder: (context, position) {
            return _buildpageItem(lsttoporder![position]);
          }),
    );
  }

  Widget _buildpageItem(TopOrderModel toporder) {
    return Stack(children: [
      Container(
        height: 260,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(toporder.foodpic!),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 80,
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Container(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  toporder.name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "4.5",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "412",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "comments",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
