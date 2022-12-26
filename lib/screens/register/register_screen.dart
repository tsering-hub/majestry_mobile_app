import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majestry_mobile_app/model/user_model.dart';
import 'package:majestry_mobile_app/repository/user_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();

  _registerUser(UserModel user) async {
    bool isSignup = await UserRepository().registerUser(user);
    _displayMessage(isSignup);
  }

  _displayMessage(bool isSignup) {
    if (isSignup) {
      // displaySuccessMessage(context, "Register Success");
      Navigator.pushNamed(context, "/loginScreen");
    } else {
      displayErrorMessage(context, "Register Failed");
    }
  }

  bool _isObscure = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                    child: SvgPicture.asset('assets/icons/register_logo.svg',
                        semanticsLabel: 'Acme Logo'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Username';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      style: const TextStyle(fontSize: 19),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Username",
                        prefixIcon: Icon(Icons.account_circle),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Name';
                        }
                        return null;
                      },
                      controller: _nameController,
                      style: const TextStyle(fontSize: 19),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Name",
                        prefixIcon: Icon(Icons.account_circle),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width * 0.8,
                    child: TextFormField(
                      key: const ValueKey("txtEmail"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      style: const TextStyle(fontSize: 19),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width * 0.8,
                    child: TextFormField(
                      key: const ValueKey("txtPassword"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: _isObscure,
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width * 0.8,
                    child: TextFormField(
                      key: const ValueKey("txtconfirmPassword"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Confirm Password';
                        }
                        return null;
                      },
                      controller: _cpasswordController,
                      obscureText: _isObscure2,
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                          icon: Icon(_isObscure2
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    height: 45,
                    child: ElevatedButton(
                      key: const ValueKey("btnRegister"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text ==
                              _cpasswordController.text) {
                            UserModel user = UserModel(
                              username: _usernameController.text,
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            _registerUser(user);
                          } else {
                            displayErrorMessage(context,
                                "Password and Confirm Password did not matched");
                          }
                        }
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)))),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/loginScreen",
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
