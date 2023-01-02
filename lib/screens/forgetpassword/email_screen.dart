import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: Form(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset('assets/icons/forgetpassword.svg',
                  semanticsLabel: 'Acme Logo'),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: size.width * 0.8,
              child: const Text(
                "Enter the email address associated with your account",
                style: TextStyle(
                  color: Color.fromARGB(255, 10, 43, 108),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              width: size.width * 0.8,
              child: TextFormField(
                key: const ValueKey("txtUsername"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 19),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
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
            SizedBox(
              width: size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                  key: const ValueKey("btnLogin"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/otpverificationScreen");
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Send OTP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.send)
                    ],
                  )),
            ),
          ],
        ),
      )),
    ));
  }
}
