import 'dart:convert';
import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  List<String> userInfo = [];
  int kategori = 1, gender = 1, bersedia = 1;
  String nij = "",
      tanggalLahir = "",
      nameField = "",
      nomorField = "",
      tanggalField = "";

  final nameController = TextEditingController();
  final nomorController = TextEditingController();
  final tanggalController = TextEditingController();
  final permintaanController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userInfo = prefs.getStringList('userInfo') ?? [];
      if (userInfo.isNotEmpty) {
        nij = userInfo[0];
        nameController.text = userInfo[1];
        nomorController.text = userInfo[2];
        tanggalController.text = userInfo[3];
        gender = int.parse(userInfo[5]);
      }
    });
  }

  Future<void> kirimPermohonan() async {
    if (nameController.text.isEmpty ||
        nomorController.text.isEmpty ||
        tanggalController.text.isEmpty ||
        tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the fields")));
    } else {
      try {
        String uri = "https://bethanylampung.com/services/m/doa_add.php";

        var res = await http.post(Uri.parse(uri), body: {
          "NIJ": nij,
          "Full_Name": nameController.text,
          "Phone_Number": nomorController.text,
          "Born_Date": tanggalController.text,
          "Gender": gender.toString(),
          "Category_ID": kategori.toString(),
          "Prayer_Detail": permintaanController.text,
          "Visit": bersedia.toString(),
        });

        var response = jsonDecode(res.body);
        if (response["success"] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Permintaan berhasil dikirim")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MainPage()),
              ModalRoute.withName("/Home"));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response["message"])));
          print(response["message"]);
          print(tanggalController.text);
        }
      } catch (e) {
        print(e);
      }
    }
  }

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
        title: const Text("Doa & Konseling"),
      ),
       backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
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
                  //TextField
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
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Text("Nomor Telepon"),
                      ],
                    ),
                  ),
                  MyTextField(
                    controller: nomorController,
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
                  // umur & gender
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: Row(
                      children: [
                        Text("Tanggal Lahir"),
                        SizedBox(
                          width: 100,
                        ),
                        Text("Jenis Kelamin")
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: MyTextField(
                        controller: tanggalController,
                        obscureText: false,
                        fieldHeight: 8,
                        paddingRight: 0,
                        inputType: TextInputType.none,
                        errorText: tanggalField,
                        onChange: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              tanggalField = 'Field is required';
                            });
                          } else {
                            setState(() {
                              tanggalField = "";
                            });
                          }
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          String? tanggalLahir =
                              pickedDate?.toString().split(' ')[0];
                          if (tanggalLahir != null && tanggalLahir.isNotEmpty) {
                            tanggalController.text = tanggalLahir;
                          } else {
                            tanggalController.text = "";
                          }
                        },
                      )),
                      Expanded(
                        child: Column(children: [
                          RadioListTile(
                            title: const Text('Pria'),
                            value: 1,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Wanita'),
                            value: 2,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ]),
                      ),
                      const SizedBox(
                        width: 30.0,
                      )
                    ],
                  ),
                  //kategori
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [Text("Kategori")],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: DropdownButton(
                      dropdownColor:  Colors.white,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Bisnis dan Keuangan'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Hubungan dan Pertemanan'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('Keluarga, Saudara dan Pernikahan'),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text('Kesehatan'),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text('Keselamatan'),
                        ),
                        DropdownMenuItem(
                          value: 6,
                          child: Text('Studi dan Sekolah'),
                        ),
                        DropdownMenuItem(
                          value: 7,
                          child: Text('Lainnya'),
                        ),
                      ],
                      value: kategori,
                      onChanged: (value) {
                        setState(() {
                          kategori = value!;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                  const Text("Permintaan Khusus"),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Scrollbar(
                      controller: _scrollController,
                      child: TextField(
                        scrollController: _scrollController,
                        controller: permintaanController,
                        textAlignVertical: TextAlignVertical.top,
                        minLines: 3,
                        maxLines: 3,
                        maxLength: 500,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 8, top: 8),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Setiap permohonan doa yang masuk akan didoakan oleh tim pendoa kami. Hanya kasus-kasus tertentu yang akan dilayani oleh tim konseling. Tim kami berhak menentukan doa/kasus yang perlu ditangani lebih lanjut.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //checkbox

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
                        const Text("Saya bersedia dihubungi untuk konseling.")
                      ],
                    ),
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
    );
  }
}
