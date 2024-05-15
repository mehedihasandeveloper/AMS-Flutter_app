import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

// import 'list.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateScreen> {
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController firstnameTextEditingController =
      TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();

  final String signUpAPI = 'https://checking-tlhc.onrender.com/api/auth/signup';

  void loginData() async {
    var reqBody = {
      "username": usernameTextEditingController.text,
      "email": emailTextEditingController.text,
      "password": passwordTextEditingController.text,
      "firstname": firstnameTextEditingController.text,
      "lastname": lastnameTextEditingController.text
    };

    var response = await http.post(Uri.parse(signUpAPI),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    // const storage = FlutterSecureStorage();
    // await storage.write(key: 'token', value: jsonResponse['jwtToken']);

    print(jsonResponse);
    print(response.statusCode);
  }

  void postData() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              icon: Icon(Icons.home),
            ),
          ],
          title: const Center(
              child: Text(
            'Create New User',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 1.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.account_box),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25.0, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25.0, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.password),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25.0, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "First Name",
                            prefixIcon: Icon(Icons.first_page),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25.0, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            prefixIcon: Icon(Icons.last_page),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "Jersey25"),
                            hintStyle:
                                TextStyle(fontSize: 25.0, color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextButton(
                          onPressed: () {
                            loginData();
                            print(usernameTextEditingController.text);
                            print(emailTextEditingController.text);
                            print(passwordTextEditingController.text);
                            print(firstnameTextEditingController.text);
                            print(lastnameTextEditingController.text);
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
