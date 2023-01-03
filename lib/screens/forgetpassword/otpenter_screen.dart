import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majestry_mobile_app/repository/otp_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';

class OtpenterScreen extends StatefulWidget {
  const OtpenterScreen({Key? key}) : super(key: key);

  @override
  State<OtpenterScreen> createState() => _OtpenterScreenState();
}

class _OtpenterScreenState extends State<OtpenterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  _resetPassword(String email, String otpcode, String password) async {
    bool isChanged =
        await OtpRepository().resetPassword(email, otpcode, password);
    if (isChanged) {
      Navigator.pushNamed(
        context,
        "/loginScreen",
      );
      // ignore: use_build_context_synchronously
      displaySuccessMessage(context, "Password Reset Successfully");
    } else {
      // ignore: use_build_context_synchronously
      displayErrorMessage(context, "Failed To reset Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reset Password"),
        ),
        body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: SvgPicture.asset('assets/icons/otpenter.svg',
                          semanticsLabel: 'Acme Logo'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.8,
                      child: const Text(
                        "Enter OTP Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 10, 43, 108),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.8,
                      child: TextFormField(
                        controller: _otpController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter otp code';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 19),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "OTP code",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.8,
                      child: TextFormField(
                        controller: _newpasswordController,
                        key: const ValueKey("txtPassword"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please New Password';
                          }
                          return null;
                        },
                        obscureText: _isObscure,
                        style: const TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "New Password",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: size.width * 0.8,
                      child: TextFormField(
                        controller: _confirmpasswordController,
                        key: const ValueKey("txtconfirmPassword"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Confirm Password';
                          }
                          return null;
                        },
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: 45,
                      child: ElevatedButton(
                          key: const ValueKey("btnLogin"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_newpasswordController.text ==
                                  _confirmpasswordController.text) {
                                _resetPassword(email, _otpController.text,
                                    _newpasswordController.text);
                              } else {
                                displayErrorMessage(context,
                                    "New Password and Confirm Password did not matched");
                              }
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Change Passwprd",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.done)
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
