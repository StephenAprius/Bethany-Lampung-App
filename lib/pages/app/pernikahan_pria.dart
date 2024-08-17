// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/app/pernikahan_wanita_page.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PernikahanPriaPage extends StatefulWidget {
  const PernikahanPriaPage({super.key});

  @override
  State<PernikahanPriaPage> createState() => _PernikahanPriaPageState();
}

class _PernikahanPriaPageState extends State<PernikahanPriaPage> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  String nij = "",
      Groom_Name = "",
      Groom_Address = "",
      Groom_Phone_Number = "",
      Groom_Born_Place = "",
      Groom_Born_Date = "",
      Groom_Father = "",
      Groom_Mother = "",
      Bride_Name = "",
      Bride_Address = "",
      Bride_Phone_Number = "",
      Bride_Born_Place = "",
      Bride_Born_Date = "",
      Bride_Father = "",
      Bride_Mother = "",
      Blessing_Date = "",
      Address_After_Married = "",
      Phone_After_Married = "",
      Groom_Home_Number = "",
      Groom_Office_Number = "",
      Bride_Home_Number = "",
      Bride_Office_Number = "";

  int load = 0, inputMarriage = 0;
  List<String> userInfo = [];

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = prefs.getStringList('userInfo') ?? [];
    if (userInfo.isNotEmpty) {
      nij = userInfo[0];
      _marriageCheck();
    }
  }

  Future<void> _marriageCheck() async {
    String uri = "https://bethanylampung.com/services/m/marriage_check.php";
    var res = await http.post(Uri.parse(uri), body: {"NIJ": nij});
    var response = jsonDecode(res.body);
    setState(() {
      load = 1;
      inputMarriage = response["success"];
      if (response["success"] == 1) {
        Groom_Name = response["data"]["Groom_Name"];
        Groom_Address = response["data"]["Groom_Address"];
        Groom_Phone_Number = response["data"]["Groom_Phone_Number"];
        Groom_Born_Place = response["data"]["Groom_Born_Place"];
        Groom_Born_Date = response["data"]["Groom_Born_Date"];
        Groom_Father = response["data"]["Groom_Father"];
        Groom_Mother = response["data"]["Groom_Mother"];
        Bride_Name = response["data"]["Bride_Name"];
        Bride_Address = response["data"]["Bride_Address"];
        Bride_Phone_Number = response["data"]["Bride_Phone_Number"];
        Bride_Born_Place = response["data"]["Bride_Born_Place"];
        Bride_Born_Date = response["data"]["Bride_Born_Date"];
        Bride_Father = response["data"]["Bride_Father"];
        Bride_Mother = response["data"]["Bride_Mother"];
        Blessing_Date = response["data"]["Blessing_Date"];
        Address_After_Married = response["data"]["Address_After_Married"];
        Phone_After_Married = response["data"]["Phone_After_Married"];
        Groom_Home_Number = response["data"]["Groom_Home_Number"];
        Groom_Office_Number = response["data"]["Groom_Office_Number"];
        Bride_Home_Number = response["data"]["Bride_Home_Number"];
        Bride_Office_Number = response["data"]["Bride_Office_Number"];
      }
    });
  }

  String tanggalLahir = "",
      nameField = "",
      alamatField = "",
      tempatField = "",
      telpField = "",
      hpField = "",
      ayahField = "",
      ibuField = "",
      kantorField = "";

  final nameController = TextEditingController();

  final alamatController = TextEditingController();

  final telpController = TextEditingController();

  final kantorController = TextEditingController();

  final hpController = TextEditingController();

  final tanggalController = TextEditingController();

  final tempatController = TextEditingController();

  final ayahController = TextEditingController();

  final ibuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Pernikahan"),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: load == 0
            ? Column()
            : inputMarriage == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Scaffold(
                        backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
                        body: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  children: [
                                    Text(
                                      "Data Calon Mempelai Pria",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Text("Nama Lengkap"),
                                  ],
                                ),
                              ),
                              MyTextField(
                                controller: nameController,
                                obscureText: false,
                                fieldHeight: 8,
                                paddingLeft: 25,
                                paddingRight: 25,
                                errorText: nameField,
                                onChange: (String value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      nameField = 'Field is required';
                                    });
                                  } else {
                                    setState(() {
                                      nameField = "";
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Text("Alamat Lengkap"),
                                  ],
                                ),
                              ),
                              MyTextField(
                                controller: alamatController,
                                obscureText: false,
                                fieldHeight: 8,
                                fieldBottom: 50,
                                errorText: alamatField,
                                onChange: (String value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      alamatField = 'Field is required';
                                    });
                                  } else {
                                    setState(() {
                                      alamatField = "";
                                    });
                                  }
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Text("Nomor Telpon Kantor"),
                                  ],
                                ),
                              ),
                              MyTextField(
                                controller: kantorController,
                                obscureText: false,
                                fieldHeight: 8,
                                paddingLeft: 25,
                                paddingRight: 25,
                                inputType: TextInputType.number,
                                errorText: kantorField,
                                onChange: (String value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      kantorField = 'Field is required';
                                    });
                                  } else {
                                    setState(() {
                                      kantorField = "";
                                    });
                                  }
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text("Nomor Hp")),
                                        Expanded(child: Text("Telp Rumah")),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: MyTextField(
                                        controller: hpController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        paddingRight: 5,
                                        inputType: TextInputType.number,
                                        errorText: hpField,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              hpField = 'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              hpField = "";
                                            });
                                          }
                                        },
                                      )),
                                      Expanded(
                                          child: MyTextField(
                                        controller: telpController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        paddingLeft: 0,
                                        inputType: TextInputType.number,
                                        errorText: telpField,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              telpField = 'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              telpField = "";
                                            });
                                          }
                                        },
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text("Tempat Lahir")),
                                        Expanded(child: Text("Tanggal Lahir"))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: MyTextField(
                                        controller: tempatController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        inputType: TextInputType.text,
                                        paddingRight: 5,
                                        errorText: tempatField,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              tempatField = 'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              tempatField = "";
                                            });
                                          }
                                        },
                                      )),
                                      Expanded(
                                          child: MyTextField(
                                        controller: tanggalController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        paddingLeft: 0,
                                        inputType: TextInputType.none,
                                        errorText: tanggalLahir,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              tanggalLahir =
                                                  'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              tanggalLahir = "";
                                            });
                                          }
                                        },
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime
                                                      .now(), //get today's date
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          String? tanggalLahir = pickedDate
                                              ?.toString()
                                              .split(' ')[0];
                                          if (tanggalLahir != null &&
                                              tanggalLahir.isNotEmpty) {
                                            tanggalController.text =
                                                tanggalLahir;
                                          } else {
                                            tanggalController.text = "";
                                          }
                                        },
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text("Nama Ayah Kandung")),
                                        Expanded(
                                            child: Text("Nama Ibu Kandung"))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: MyTextField(
                                        controller: ayahController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        paddingRight: 5,
                                        errorText: ayahField,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              ayahField = 'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              ayahField = "";
                                            });
                                          }
                                        },
                                      )),
                                      Expanded(
                                          child: MyTextField(
                                        controller: ibuController,
                                        obscureText: false,
                                        fieldHeight: 8,
                                        paddingLeft: 0,
                                        errorText: ibuField,
                                        onChange: (String value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              ibuField = 'Field is required';
                                            });
                                          } else {
                                            setState(() {
                                              ibuField = "";
                                            });
                                          }
                                        },
                                      )),
                                    ],
                                  ),
                                ],
                              ),

                              // button kirim

                              const SizedBox(
                                height: 10,
                              ),

                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                      child: Text(
                                    "Selanjutnya",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                                ),
                                onTap: () {
                                  if (nameController.text.isEmpty ||
                                      alamatController.text.isEmpty ||
                                      hpController.text.isEmpty ||
                                      telpController.text.isEmpty ||
                                      tempatController.text.isEmpty ||
                                      tanggalController.text.isEmpty ||
                                      ayahController.text.isEmpty ||
                                      ibuController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "please fill all fields")));
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PernikahanWanitaPage(
                                          NIJ: nij,
                                          Groom_Name: nameController.text,
                                          Groom_Address: alamatController.text,
                                          Groom_Office_Number:
                                              kantorController.text,
                                          Groom_Home_Number:
                                              telpController.text,
                                          Groom_Phone_Number: hpController.text,
                                          Groom_Born_Date:
                                              tanggalController.text,
                                          Groom_Born_Place:
                                              tempatController.text,
                                          Groom_Father: ayahController.text,
                                          Groom_Mother: ibuController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scaffold(
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Data Mempelai Pria",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.amber),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Nama Lengkap",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Name,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Alamat Lengkap",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Address,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nomor Telpon Kantor",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Office_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nomor Hp",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Phone_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Telp Rumah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Home_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Tempat Lahir",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Born_Place,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Tanggal Lahir",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Born_Date,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nama Ayah Kandung",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Father,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nama Ibu Kandung",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Groom_Mother,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "Data Mempelai Wanita",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.amber),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Nama Lengkap",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Name,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Alamat Lengkap",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Address,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nomor Telpon Kantor",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Office_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nomor Hp",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Phone_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Telp Rumah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Home_Number,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Tempat Lahir",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Born_Place,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Tanggal Lahir",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Born_Date,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nama Ayah Kandung",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Father,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Nama Ibu Kandung",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Bride_Mother,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "Pernikahan",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.amber),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Pemberkatan Nikah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Blessing_Date,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Alamat Lengkap setelah menikah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Address_After_Married,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Telp Rumah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(Phone_After_Married,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
