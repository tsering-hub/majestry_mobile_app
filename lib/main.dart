import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/screens/forgetpassword/email_screen.dart';
import 'package:majestry_mobile_app/screens/forgetpassword/otpenter_screen.dart';
import 'package:majestry_mobile_app/screens/home/home_screen.dart';
import 'package:majestry_mobile_app/screens/login/login_screen.dart';
import 'package:majestry_mobile_app/screens/register/register_screen.dart';
import 'package:majestry_mobile_app/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const SplashScreen(),
      "/loginScreen": (context) => const LoginScreen(),
      "/registerScreen": (context) => const RegistrationScreen(),
      "/homeScreen": (context) => const HomeScreen(),
      "/forgetpasswordEmailScreen": (context) => const EmailScreen(),
      "/otpverificationScreen": (context) => const OtpenterScreen(),
    },
  ));
}
