import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:majestry_mobile_app/screens/home/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majestry_mobile_app/screens/order/pendingOrder_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> lstWidget = [
    const HomeScreen(),
    const PendingOrderScreen(),
    const Scaffold(),
    const Scaffold(),
  ];

  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      Navigator.pushNamed(context, "/foodsScreen", arguments: qrdata);
      print(qrdata);
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        Navigator.pushNamed(context, "/foodsScreen", arguments: qrdata);
        print(qrdata);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: SvgPicture.asset(
            'assets/icons/logo.svg',
            semanticsLabel: 'Logo',
            height: 35,
          ),
          automaticallyImplyLeading: false,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
            )
          ],
        ),
        body: Center(
          child: lstWidget[_selectedIndex],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF854D27),
          onPressed: () {
            _qrScanner();
          },
          child: const Icon(Icons.qr_code), //icon inside button
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floating action button position to center

        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFDD7230),
          elevation: 10,
          shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin:
              5, //notche margin between floating button and bottom appbar
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.house,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bagShopping,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(
                  Icons.announcement_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.userLarge,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_basket),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.verified_user),
//             label: 'Profile',
//           ),
//         ],
//         backgroundColor: Colors.amber[200],
//         currentIndex: _selectedIndex,
//         unselectedItemColor: Colors.grey,
//         elevation: 10,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
