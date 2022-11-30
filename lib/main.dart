import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/screens/home/home_screen.dart';
import 'package:majestry_mobile_app/screens/login/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const LoginScreen(),
      "/home": (context) => const HomeScreen(),
    },
  ));
}
