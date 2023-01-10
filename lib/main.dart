import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:majestry_mobile_app/screens/cart/cart_screen.dart';
import 'package:majestry_mobile_app/screens/dashboard/dashboard_screen.dart';
import 'package:majestry_mobile_app/screens/food/foods_screen.dart';
import 'package:majestry_mobile_app/screens/forgetpassword/email_screen.dart';
import 'package:majestry_mobile_app/screens/forgetpassword/otpenter_screen.dart';
import 'package:majestry_mobile_app/screens/home/home_screen.dart';
import 'package:majestry_mobile_app/screens/login/login_screen.dart';
import 'package:majestry_mobile_app/screens/order/AllOrders_screen.dart';
import 'package:majestry_mobile_app/screens/profile/profile_screeen.dart';
import 'package:majestry_mobile_app/screens/register/register_screen.dart';
import 'package:majestry_mobile_app/screens/splash_screen.dart';

void main() {
  runApp(KhaltiScope(
    publicKey: 'test_public_key_078a1cda4e5b447ba2740355208dd281',
    enabledDebugging: true,
    builder: (context, navKey) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navKey,
        localizationsDelegates: const [KhaltiLocalizations.delegate],
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/loginScreen": (context) => const LoginScreen(),
          "/registerScreen": (context) => const RegistrationScreen(),
          "/homeScreen": (context) => const HomeScreen(),
          "/dashboardScreen": (context) => const DashboardScreen(),
          "/forgetpasswordEmailScreen": (context) => const EmailScreen(),
          "/otpverificationScreen": (context) => const OtpenterScreen(),
          "/foodsScreen": (context) => const FoodsScreen(),
          "/cartScreen": (context) => const CartScreen(),
          "/allordersScreen": (context) => const AllOrderScreen(),
          "/profileScreen": (context) => const ProfileUpdateScreen()
        },
      );
    },
  ));
}
