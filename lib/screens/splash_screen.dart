import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:majestry_mobile_app/screens/food/foods_screen.dart';
import 'package:majestry_mobile_app/screens/login/login_screen.dart';
import 'package:majestry_mobile_app/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString("my_token");
    final String? value3 = prefs.getString("usertype");
    if (value != null) {
      setState(() {
        token = value;
        usertype = value3;
      });
    } else {
      setState(() {
        token = "null";
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _getDataFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Widget? nextscreen;
    if (token == "null") {
      nextscreen = const LoginScreen();
    } else {
      if (usertype == "Customer") {
        nextscreen = const FoodsScreen();
      } else {
        nextscreen = const LoginScreen();
      }
    }
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/icons/40888-yellow-qr-code-menu.json"),
      nextScreen: nextscreen,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
    );
  }
}
