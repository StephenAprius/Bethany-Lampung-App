import 'dart:convert';
import 'package:bethany_app/pages/login_Page.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:bethany_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jiffy/jiffy.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();

  final telpController = TextEditingController();

  final tanggalController = TextEditingController();

  String tanggalLahir = "",
      userField = "",
      nomorField = "",
      passwordField = "",
      conPasswordField = "";

  int gender = 1;

  String _emailErrorText = "";
  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'Email is required';
      });
    } else if (isEmailValid(value) == false) {
      setState(() {
        _emailErrorText = "Email not valid";
      });
    } else {
      setState(() {
        _emailErrorText = "";
      });
    }
  }

  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage()),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),

                      //logo
                      Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.contain,
                        height: 130,
                      ),
                      //Welcome back, you've been missed!
                      const Text(
                        'Formulir Registrasi',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      MyTextField(
                          controller: usernameController,
                          hintText: 'Nama Lengkap',
                          obscureText: false,
                          fieldHeight: 10,
                          errorText: userField,
                          onChange: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                userField = 'Field is required';
                              });
                            } else {
                              setState(() {
                                userField = "";
                              });
                            }
                          }),

                      const SizedBox(
                        height: 10,
                      ),
                      //email text field
                      MyTextField(
                        controller: telpController,
                        hintText: 'Nomor Telepon',
                        obscureText: false,
                        fieldHeight: 10,
                        inputType: TextInputType.number,
                        errorText: nomorField,
                        onChange: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              nomorField = 'Field is required';
                            });
                          } else {
                            setState(() {
                              nomorField = "";
                            });
                          }
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      MyTextField(
                        controller: tanggalController,
                        obscureText: false,
                        hintText: "Tanggal Lahir",
                        fieldHeight: 8,
                        inputType: TextInputType.none,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  Jiffy.now().subtract(years: 100).dateTime,
                              lastDate: DateTime.now());

                          String? tanggalLahir =
                              pickedDate?.toString().split(' ')[0];
                          if (tanggalLahir != null && tanggalLahir.isNotEmpty) {
                            tanggalController.text = tanggalLahir;
                          } else {
                            tanggalController.text = "";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //password text field
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        fieldHeight: 10,
                        errorText: _emailErrorText,
                        onChange: _validateEmail,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          fieldHeight: 10,
                          errorText: passwordField,
                          onChange: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                passwordField = 'Bagian ini harus terisi';
                              });
                            } else {
                              setState(() {
                                passwordField = "";
                              });
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),

                      MyTextField(
                          controller: conPasswordController,
                          hintText: 'Konfirmasi Password',
                          obscureText: true,
                          fieldHeight: 10,
                          errorText: conPasswordField,
                          onChange: (String value) {
                            if (value != passwordController.text) {
                              setState(() {
                                conPasswordField = 'Password Tidak Sama';
                              });
                            } else {
                              setState(() {
                                conPasswordField = "";
                              });
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Text("Jenis Kelamin"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300, // Set the desired width for the entire Row
                        child: Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Pria'),
                                value: 1,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                                width:
                                    30), // Adjust this width to control the gap between items
                            Flexible(
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Wanita'),
                                value: 2,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // forgot password
                      const SizedBox(
                        height: 20,
                      ),
                      //sign Up button
                      IgnorePointer(
                        ignoring: passwordController.text ==
                                conPasswordController.text
                            ? false
                            : true,
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: passwordController.text ==
                                        conPasswordController.text
                                    ? const Color.fromARGB(255, 195, 160, 20)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: Text(
                              "Daftar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                          ),
                          onTap: () async {
                            if (usernameController.text == "" ||
                                emailController.text == "" ||
                                passwordController.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Ada bagian formulir yang masih belum terisi")));
                            } else {
                              try {
                                String uri =
                                    "https://bethanylampung.com/services/m/user_add.php";

                                var res =
                                    await http.post(Uri.parse(uri), body: {
                                  "Full_Name": usernameController.text,
                                  "Phone_Number": telpController.text,
                                  "Born_Date": tanggalController.text,
                                  "Email": emailController.text,
                                  "Password": passwordController.text,
                                  "Gender": gender.toString(),
                                  "Created_By": "User",
                                });

                                var response = jsonDecode(res.body);

                                if (response["success"] == 1) {
                                  String nij = response["data"]["NIJ"];
                                  String fullName =
                                      response["data"]["Full_Name"];
                                  String phoneNumber =
                                      response["data"]["Phone_Number"];
                                  String bornDate =
                                      response["data"]["Born_Date"];
                                  String email = response["data"]["Email"];
                                  String gender = response["data"]["Gender"];
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setStringList(
                                      'userInfo', <String>[
                                    nij,
                                    fullName,
                                    phoneNumber,
                                    bornDate,
                                    email,
                                    gender
                                  ]);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Register successfull!")));
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
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun?',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            child: const Text(
                              'Masuk sekarang',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 195, 160, 20),
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()));
                            },
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
