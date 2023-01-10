import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/repository/user_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';
import 'package:majestry_mobile_app/utils/url.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _contactnoController = TextEditingController();
  final _genderController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _confirmnewpasswordController = TextEditingController();
  final _oldpasswordController = TextEditingController();

  _updatePatientProfile(UserModel user) async {
    bool isUpdated = await UserRepository().updateProfile(user);
    _displayMessage(isUpdated);
  }

  _updateUserPassword(String oldpassword, String newpassword) async {
    bool isUpdated =
        await UserRepository().updatePassword(oldpassword, newpassword);
    _displayMessage(isUpdated);
  }

  _updateUserProfilePic(File? file) async {
    bool isUpdated = await UserRepository().updateProfilePic(file);
    _displayMessage(isUpdated);
  }

  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      Navigator.pushNamed(context, "/patientnavbar");
      displaySuccessMessage(context, "Updated Success");
    } else {
      displayErrorMessage(context, "Update Failed");
    }
  }

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      await Permission.camera.request();
      _loadImage(ImageSource.camera);
    } else {
      _loadImage(ImageSource.camera);
    }
  }

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          _updateUserProfilePic(img);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  Future showBottomModel() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 140,
            child: Column(
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  width: 350,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      requestCameraPermission();
                    },
                    icon: const Icon(Icons.camera_enhance),
                    label: const Text('Open Camera'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 350,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _loadImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.browse_gallery_sharp),
                    label: const Text('Open Gallery'),
                  ),
                ),
              ],
            ),
          );
        });
  }

  final double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel usermodel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => showBottomModel(),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: img == null
                                ? usermodel.profilepic != null
                                    ? Image.network(
                                        "$baseUrl${usermodel.profilepic}",
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                        fit: BoxFit.contain,
                                      )
                                : Image.file(
                                    img!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 20,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Username : ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${usermodel.username}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Name : ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${usermodel.name}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Email : ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${usermodel.email}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Phone Number : ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${usermodel.contactno}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 45,
                  child: ElevatedButton(
                    key: const ValueKey("btnUpdate"),
                    onPressed: () {
                      setState(() {
                        _nameController.text = usermodel.name!;
                        _contactnoController.text = usermodel.contactno!;
                      });
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 640,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          labelText: "Name",
                                          hintText: "Name",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _contactnoController,
                                        decoration: const InputDecoration(
                                          labelText: "Phone Number",
                                          hintText: "Phone Number",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              // if (_formKey.currentState!
                                              //     .validate()) {
                                              //   UserModel patient =
                                              //       UserModel(
                                              //     firstname:
                                              //         _firstController.text,
                                              //     lastname:
                                              //         _lastController.text,
                                              //     email: _emailController.text,
                                              //     address:
                                              //         _addressController.text,
                                              //     phone: _phoneController.text,
                                              //   );
                                              //   _updatePatientProfile(patient);
                                              // }
                                            });
                                          },
                                          child: const Text("Update")),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: const Text(
                      "Update Profile",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: 45,
                  child: ElevatedButton(
                    key: const ValueKey("btnUpdatePassword"),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    key: const ValueKey("txtoldpassword"),
                                    controller: _oldpasswordController,
                                    decoration: const InputDecoration(
                                      labelText: "Old Password",
                                      hintText: "Old Password",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    key: const ValueKey("txtnewpassword"),
                                    controller: _newpasswordController,
                                    decoration: const InputDecoration(
                                      labelText: "New Password",
                                      hintText: "New Password",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    key:
                                        const ValueKey("txtconfirmnewpassword"),
                                    controller: _confirmnewpasswordController,
                                    decoration: const InputDecoration(
                                      labelText: "Confirm New Password",
                                      hintText: "confirm New Password",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                      key: const ValueKey("btnChangePassword"),
                                      onPressed: () {
                                        setState(() {
                                          if (_oldpasswordController.text ==
                                              _newpasswordController.text) {
                                            displayErrorMessage(context,
                                                "Old password and New password is same");
                                            return;
                                          }
                                          if (_confirmnewpasswordController
                                                  .text !=
                                              _newpasswordController.text) {
                                            displayErrorMessage(context,
                                                "New password and Confirm New password is not same");
                                            return;
                                          }
                                          _updateUserPassword(
                                              _oldpasswordController.text,
                                              _newpasswordController.text);
                                        });
                                      },
                                      child: const Text("Change")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"))
                                ],
                              ),
                            );
                          });
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))),
                    child: const Text(
                      "Change Password",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
