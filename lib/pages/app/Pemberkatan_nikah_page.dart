import 'dart:convert';

import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PemberkatanNikahPage extends StatefulWidget {
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
  final String Bride_Name;
  final String Bride_Address;
  final String Bride_Office_Number;
  final String Bride_Home_Number;
  final String Bride_Phone_Number;
  final String Bride_Born_Date;
  final String Bride_Born_Place;
  final String Bride_Father;
  final String Bride_Mother;

  const PemberkatanNikahPage({
    super.key,
    required this.NIJ,
    required this.Groom_Name,
    required this.Groom_Address,
    required this.Groom_Office_Number,
    required this.Groom_Home_Number,
    required this.Groom_Phone_Number,
    required this.Groom_Born_Date,
    required this.Groom_Born_Place,
    required this.Groom_Father,
    required this.Groom_Mother,
    required this.Bride_Name,
    required this.Bride_Address,
    required this.Bride_Office_Number,
    required this.Bride_Home_Number,
    required this.Bride_Phone_Number,
    required this.Bride_Born_Date,
    required this.Bride_Born_Place,
    required this.Bride_Father,
    required this.Bride_Mother,
  });

  @override
  State<PemberkatanNikahPage> createState() => _PemberkatanNikahPageState();
}

class _PemberkatanNikahPageState extends State<PemberkatanNikahPage> {
  final tanggalController = TextEditingController();
  final jamController = TextEditingController();
  final alamatSetelahController = TextEditingController();
  final telpController = TextEditingController();

  int bersedia = 1;
  String tanggalPemberkatan = "";

  Future<void> kirimPermohonan() async {
    String date = tanggalController.text;
    String time = jamController.text;

    if (telpController.text.isEmpty ||
        tanggalController.text.isEmpty ||
        alamatSetelahController.text.isEmpty ||
        jamController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please fill all fields")));
    } else {
      try {
        String uri = "https://bethanylampung.com/services/m/marriage_add.php";

        var res = await http.post(Uri.parse(uri), body: {
          "NIJ": widget.NIJ,
          "Groom_Name": widget.Groom_Name,
          "Groom_Address": widget.Groom_Address,
          "Groom_Office_Number": widget.Groom_Office_Number,
          "Groom_Phone_Number": widget.Groom_Phone_Number,
          "Groom_Home_Number": widget.Groom_Home_Number,
          "Groom_Born_Place": widget.Groom_Address,
          "Groom_Born_Date": widget.Groom_Born_Date,
          "Groom_Father": widget.Groom_Father,
          "Groom_Mother": widget.Groom_Mother,
          "Bride_Name": widget.Bride_Name,
          "Bride_Address": widget.Bride_Address,
          "Bride_Office_Number": widget.Bride_Office_Number,
          "Bride_Phone_Number": widget.Bride_Phone_Number,
          "Bride_Home_Number": widget.Bride_Home_Number,
          "Bride_Born_Place": widget.Bride_Born_Place,
          "Bride_Born_Date": widget.Bride_Born_Date,
          "Bride_Father": widget.Bride_Father,
          "Bride_Mother": widget.Bride_Mother,
          "Blessing_Date": "$date $time:00",
          "Address_After_Married": alamatSetelahController.text,
          "Phone_After_Married": telpController.text,
          "BrideGroom_Approval": bersedia.toString(),
        });

        var response = jsonDecode(res.body);
        if (response["success"] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("pendaftaran terkirim!")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MainPage()),
              ModalRoute.withName("/Home"));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response["message"])));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
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
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height / 3.5,
        child: SafeArea(
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
                            "Pemberkatan Nikah",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          )
                        ],
                      ),
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
                              Expanded(child: Text("Tanggal")),
                              Expanded(child: Text("Jam")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: tanggalController,
                                obscureText: false,
                                fieldHeight: 8,
                                paddingRight: 5,
                                inputType: TextInputType.none,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
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
                              ),
                            ),
                            Expanded(
                                child: MyTextField(
                              controller: jamController,
                              obscureText: false,
                              paddingLeft: 0,
                              inputType: TextInputType.none,
                              onTap: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: selectedTime,
                                        initialEntryMode:
                                            TimePickerEntryMode.dial);
                                if (timeOfDay != null) {
                                  jamController.text =
                                      "${selectedTime.hour}:${selectedTime.minute}";
                                }
                              },
                            ))
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Text("Alamat Lengkap setelah menikah"),
                        ],
                      ),
                    ),
                    MyTextField(
                      controller: alamatSetelahController,
                      hintText: "",
                      obscureText: false,
                      fieldBottom: 50,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Text("Telp Rumah"),
                        ],
                      ),
                    ),
                    MyTextField(
                      controller: telpController,
                      hintText: "",
                      inputType: TextInputType.number,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Data ini telah kami isi sesuai dengan yang sebenarnya. kami bertanggung jawab sepenuhnya akan hal tersebut. Dan kami bersedia memenuhi persyaratan untuk pemberkatan Nikah di Bethany Lampung",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),

                    // button kirim

                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: bersedia == 1 ? true : false,
                            onChanged: (value) {
                              setState(() {
                                bersedia = bersedia == 1 ? 0 : 1;
                              });
                            },
                          ),
                          const Text("Kami setuju dengan pernyataan diatas.")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                          "Kirim",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                      onTap: () {
                        kirimPermohonan();
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
