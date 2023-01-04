import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:majestry_mobile_app/screens/home/food_page_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 15,
            ),
            FoodPageBody()
          ],
        ),
      ),
    );
  }
}
