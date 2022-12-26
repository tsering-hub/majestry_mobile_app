import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:majestry_mobile_app/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/icons/40888-yellow-qr-code-menu.json"),
      nextScreen: const LoginScreen(),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
    );
  }
}
