import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<SettingsList> lstsettings = [
    SettingsList(Icons.verified_user, "Edit Profile", "Edit your information"),
    SettingsList(Icons.shopping_bag, "All Orders", "Your All Orders Details"),
    SettingsList(Icons.info_sharp, "About", "Our details"),
    SettingsList(Icons.logout, "Logout", "Logout form this device"),
  ];

  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('my_token');
    await preferences.remove('username');
    await preferences.remove('usertype');
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                key: ValueKey("btnSetting$index"),
                onTap: () => {
                  if (index == 3)
                    {_logout()}
                  else if (index == 0)
                    {
                      // Navigator.pushNamed(context, "/ProfileUpdateScreen",
                      //     arguments: patientmodel)
                    }
                  else if (index == 1)
                    {
                      Navigator.pushNamed(
                        context,
                        "/MyOrderScreen",
                      )
                    }
                  else if (index == 2)
                    {
                      Navigator.pushNamed(
                        context,
                        "/aboutus",
                      )
                    }
                },
                child: ListTile(
                    title: Text("${lstsettings[index].title}"),
                    subtitle: Text("${lstsettings[index].subtitle}"),
                    leading: Icon(
                      lstsettings[index].leadingicon,
                      color: Colors.orange[900],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios)),
              );
            },
            childCount: lstsettings.length,
          ),
        ),
      ],
    );
  }
}

class SettingsList {
  IconData? leadingicon;
  String? title;
  String? subtitle;

  SettingsList(
    this.leadingicon,
    this.title,
    this.subtitle,
  );
}
