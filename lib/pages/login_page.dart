import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
                        controller: usernameTextEditingController,
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
                        controller: passwordTextEditingController,
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
                          print(usernameTextEditingController.text);
                          print(passwordTextEditingController.text);
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
                          height: 30.0,
                          width: 100.0,
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
