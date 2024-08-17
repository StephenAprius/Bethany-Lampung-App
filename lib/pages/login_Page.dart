import 'dart:convert';

import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:bethany_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final nijController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in method
  void signIn() {}

  String nijField = "", passwordField = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => const MainPage()),
          );
          return false;
        },
        child: Scaffold(
           backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      //logo
                      Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.contain,
                        height: 150,
                      ),

                      const SizedBox(height: 20),
                      //Welcome back, you've been missed!
                     const  Text(
                        'Masuk ke gereja Bethany Lampung app',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //username text field
                      MyTextField(
                        controller: nijController,
                        hintText: 'NIJ',
                        obscureText: false,
                        fieldHeight: 10,
                        inputType: TextInputType.number,
                        errorText: nijField,
                        onChange: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              nijField = 'Field is required';
                            });
                          } else {
                            setState(() {
                              nijField = "";
                            });
                          }
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //password text field
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        fieldHeight: 10,
                        errorText: passwordField,
                        onChange: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              passwordField = 'Field is required';
                            });
                          } else {
                            setState(() {
                              passwordField = "";
                            });
                          }
                        },
                      ),

                      // forgot password
                      const SizedBox(
                        height: 40,
                      ),
                      //sign in button
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                           color: const Color.fromARGB(255, 195, 160, 20),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                              child: Text(
                            "Masuk",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                        ),
                        onTap: () async {
                          if (nijController.text == "" ||
                              passwordController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Fill all fields!")));
                          } else {
                            try {
                              String uri =
                                  "https://bethanylampung.com/services/m/user_login.php";

                              var res = await http.post(Uri.parse(uri), body: {
                                "NIJ": nijController.text,
                                "Password": passwordController.text,
                              });

                              var response = jsonDecode(res.body);

                              if (response["success"] == 1) {
                                String nij = response["data"]["NIJ"];
                                String fullName = response["data"]["Full_Name"];
                                String phoneNumber =
                                    response["data"]["Phone_Number"];
                                String bornDate = response["data"]["Born_Date"];
                                String email = response["data"]["Email"];
                                String gender = response["data"]["Gender"];
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setStringList('userInfo', <String>[
                                  nij,
                                  fullName,
                                  phoneNumber,
                                  bornDate,
                                  email,
                                  gender
                                ]);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Selamat Datang $fullName")));

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MainPage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(response["message"])));
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun?',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                              child: const Text(
                                'Daftar Sekarang',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 195, 160, 20),
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RegisterPage()));
                              })
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
