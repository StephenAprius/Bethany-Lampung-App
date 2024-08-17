// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/app/pemberkatan_nikah_page.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class PernikahanWanitaPage extends StatefulWidget {
  final String NIJ;
  final String Groom_Name;
  final String Groom_Address;
  final String Groom_Office_Number;
  final String Groom_Home_Number;
  final String Groom_Phone_Number;
  final String Groom_Born_Date;
  final String Groom_Born_Place;
  final String Groom_Father;
  final String Groom_Mother;
  const PernikahanWanitaPage(
      {required this.NIJ,
      required this.Groom_Name,
      required this.Groom_Address,
      required this.Groom_Office_Number,
      required this.Groom_Home_Number,
      required this.Groom_Phone_Number,
      required this.Groom_Born_Date,
      required this.Groom_Born_Place,
      required this.Groom_Father,
      required this.Groom_Mother,
      super.key});

  @override
  State<PernikahanWanitaPage> createState() => _PernikahanWanitaPageState();
}

class _PernikahanWanitaPageState extends State<PernikahanWanitaPage> {
  String tanggalLahir = "";

  final nameController = TextEditingController();

  final alamatController = TextEditingController();

  final kantorController = TextEditingController();

  final telpController = TextEditingController();

  final hpController = TextEditingController();

  final tanggalController = TextEditingController();

  final tempatController = TextEditingController();

  final ayahController = TextEditingController();

  final ibuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Pernikahan"),
      ),
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 5,
          child: Center(
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
                            "Data Calon Mempelai Wanita",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
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
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
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
                            )),
                            Expanded(
                                child: MyTextField(
                              controller: telpController,
                              obscureText: false,
                              fieldHeight: 8,
                              paddingLeft: 0,
                              inputType: TextInputType.number,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
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
                              paddingRight: 5,
                            )),
                            Expanded(
                                child: MyTextField(
                              controller: tanggalController,
                              obscureText: false,
                              fieldHeight: 8,
                              paddingLeft: 0,
                              inputType: TextInputType.none,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                String? tanggalLahir =
                                    pickedDate?.toString().split(' ')[0];
                                if (tanggalLahir != null &&
                                    tanggalLahir.isNotEmpty) {
                                  tanggalController.text = tanggalLahir;
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
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(child: Text("Nama Ayah Kandung")),
                              Expanded(child: Text("Nama Ibu Kandung"))
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
                            )),
                            Expanded(
                                child: MyTextField(
                              controller: ibuController,
                              obscureText: false,
                              fieldHeight: 8,
                              paddingLeft: 0,
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
                        margin: const EdgeInsets.symmetric(horizontal: 25),
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
                                  content: Text("please fill all fields")));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PemberkatanNikahPage(
                                NIJ: widget.NIJ,
                                Groom_Name: widget.Groom_Name,
                                Groom_Address: widget.Groom_Address,
                                Groom_Office_Number: widget.Groom_Office_Number,
                                Groom_Home_Number: widget.Groom_Home_Number,
                                Groom_Phone_Number: widget.Groom_Phone_Number,
                                Groom_Born_Date: widget.Groom_Born_Date,
                                Groom_Born_Place: widget.Groom_Born_Place,
                                Groom_Father: widget.Groom_Father,
                                Groom_Mother: widget.Groom_Mother,
                                Bride_Name: nameController.text,
                                Bride_Address: alamatController.text,
                                Bride_Office_Number: kantorController.text,
                                Bride_Home_Number: telpController.text,
                                Bride_Phone_Number: hpController.text,
                                Bride_Born_Date: tanggalController.text,
                                Bride_Born_Place: tempatController.text,
                                Bride_Father: ayahController.text,
                                Bride_Mother: ibuController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
