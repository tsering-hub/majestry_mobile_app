import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildpageItem(position);
          }),
    );
  }

  Widget _buildpageItem(int index) {
    return Stack(children: [
      Container(
        height: 220,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: index.isEven
              ? const Color(0xFF69c5df)
              : const Color.fromARGB(255, 154, 115, 0),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://www.countdown.co.nz/Content/Recipes/226015-images-large-quick_burgers-810x520.jpg"),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 130,
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Burger"),
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
                      width: 10,
                    ),
                    const Text(
                      "4.5",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "4122",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "comments",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [],
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
