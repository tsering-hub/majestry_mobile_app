import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/repository/user_repository.dart';
import 'package:majestry_mobile_app/response/user_response.dart';
import 'package:majestry_mobile_app/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserModel? userModel;
  String? profilePicture;
  List<SettingsList> lstsettings = [
    SettingsList(Icons.verified_user, "Edit Profile", "Edit your information"),
    SettingsList(Icons.shopping_bag, "All Orders", "Your All Orders Details"),
    SettingsList(Icons.info_sharp, "About", "Our details"),
    SettingsList(Icons.logout, "Logout", "Logout form this device"),
  ];

  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('my_token');
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FutureBuilder<UserResponse?>(
            future: UserRepository().getMe(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  userModel = snapshot.data!.data!;

                  if (userModel!.profilepic == null) {
                    profilePicture =
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png";
                  } else {
                    profilePicture = "$baseUrl${userModel!.profilepic}";
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profilePicture!),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userModel!.username}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Email: ${userModel!.email}"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
            },
          ),
        ),
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
                      Navigator.pushNamed(context, "/profileScreen",
                          arguments: userModel)
                    }
                  else if (index == 1)
                    {
                      Navigator.pushNamed(
                        context,
                        "/allordersScreen",
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
