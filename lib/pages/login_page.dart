import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameLoginTextEditingController =
      TextEditingController();
  TextEditingController passwordLoginTextEditingController =
      TextEditingController();

  final String loginAPI = 'https://checking-tlhc.onrender.com/api/auth/signin';

  void loginData() async {
    var reqBody = {
      "username": usernameLoginTextEditingController.text,
      "password": passwordLoginTextEditingController.text
    };

    var response = await http.post(Uri.parse(loginAPI),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: jsonResponse['jwtToken']);

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      print("Login unsuccessful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage("images/logoams.png"),
                  width: 250.0,
                  height: 200.0,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: usernameLoginTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(fontSize: 25, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: passwordLoginTextEditingController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextButton(
                        onPressed: () {
                          print(usernameLoginTextEditingController.text);
                          print(passwordLoginTextEditingController.text);
                          loginData();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const HomePage(),
                          //     ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                        color: Colors.white)))),
                        child: const SizedBox(
                          height: 45.0,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Jersey25",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
