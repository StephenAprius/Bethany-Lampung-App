import 'dart:convert';
import 'package:bethany_app/components/my_textfield.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaptisPage extends StatefulWidget {
  const BaptisPage({super.key});

  @override
  State<BaptisPage> createState() => _BaptisPageState();
}

class _BaptisPageState extends State<BaptisPage> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  int load = 0, inputBaptis = 0, gender = 1, bergereja = 1;
  String nij = "",
      tanggalLahir = "",
      nameField = "",
      alamatField = "",
      tempatField = "",
      telpField = "",
      hpField = "",
      ayahField = "",
      ibuField = "",
      gerejaField = "",
      Baptism_Certificate_Url = "";
  List<String> userInfo = [];

  final nameController = TextEditingController();
  final alamatController = TextEditingController();
  final tempatController = TextEditingController();
  final tanggalController = TextEditingController();
  final telpController = TextEditingController();
  final hpController = TextEditingController();
  final ayahController = TextEditingController();
  final ibuController = TextEditingController();
  final gerejaController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = prefs.getStringList('userInfo') ?? [];
    if (userInfo.isNotEmpty) {
      nij = userInfo[0];
      nameController.text = userInfo[1];
      hpController.text = userInfo[2];
      tanggalController.text = userInfo[3];
      gender = int.parse(userInfo[5]);
      _baptisCheck();
    }
  }

  Future<void> _baptisCheck() async {
    String uri = "https://bethanylampung.com/services/m/baptism_check.php";
    var res = await http.post(Uri.parse(uri), body: {"NIJ": nij});
    var response = jsonDecode(res.body);
    setState(() {
      load = 1;
      inputBaptis = response["success"];
      if (response["success"] == 1) {
        Baptism_Certificate_Url = response["data"]["Baptism_Certificate_Url"];
      }
    });
  }

  Future<void> kirimPermohonan() async {
    if (nameController.text == "" ||
        alamatController.text == "" ||
        tempatController.text == "" ||
        tanggalController.text == "" ||
        telpController.text == "" ||
        hpController.text == "" ||
        ayahController.text == "" ||
        ibuController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please fill all fields")));
    } else if (bergereja == 0) {
      if (gerejaController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("please fill all fields")));
      }
    } else {
      try {
        String uri = "https://bethanylampung.com/services/m/baptism_add.php";

        var res = await http.post(Uri.parse(uri), body: {
          "NIJ": nij,
          "Full_Name": nameController.text,
          "Gender": gender.toString(),
          "Born_Place": tempatController.text,
          "Born_Date": tanggalController.text,
          "Father_Name": ayahController.text,
          "Mother_Name": ibuController.text,
          "Address": alamatController.text,
          "Phone_Number": hpController.text,
          "Home_Phone_Number": telpController.text,
          "Church_Name":
              bergereja == 1 ? "Bethany Lampung" : gerejaController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Baptis Selam"),
      ),
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: load == 0
            ? Column()
            : inputBaptis == 0
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
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Tempat Lahir")),
                                      Expanded(child: Text("Tanggal Lahir")),
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
                                            tanggalLahir = 'Field is required';
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
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101));

                                        String? tanggalLahir = pickedDate
                                            ?.toString()
                                            .split(' ')[0];
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
                              ],
                            ),

                            // umur & gender
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Text("Jenis Kelamin"),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
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
                                Expanded(
                                  child: RadioListTile(
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

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Text("Alamat Lengkap"),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Scrollbar(
                                controller: _scrollController,
                                child: TextField(
                                  scrollController: _scrollController,
                                  controller: alamatController,
                                  textAlignVertical: TextAlignVertical.top,
                                  minLines: 3,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500])),
                                ),
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
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text("Nama Ayah Kandung")),
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
                            //checkbox

                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: bergereja == 1 ? true : false,
                                    onChanged: (value) {
                                      setState(() {
                                        bergereja = bergereja == 1 ? 0 : 1;
                                      });
                                    },
                                  ),
                                  const Text(
                                      "Saya bergereja di Bethany Lampung.")
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                if (bergereja == 0) ...[
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Row(
                                      children: [
                                        Text("Nama Gereja"),
                                      ],
                                    ),
                                  ),
                                  MyTextField(
                                    controller: gerejaController,
                                    obscureText: false,
                                    fieldHeight: 8,
                                    enabled: true,
                                  ),
                                ] else if (bergereja == 1) ...[
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Row(
                                      children: [
                                        Opacity(
                                            opacity: 0.5,
                                            child: Text("Nama Gereja")),
                                      ],
                                    ),
                                  ),
                                  MyTextField(
                                    controller: gerejaController,
                                    obscureText: false,
                                    fieldHeight: 8,
                                    enabled: false,
                                    errorText: gerejaField,
                                    onChange: (String value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          gerejaField = 'Field is required';
                                        });
                                      } else {
                                        setState(() {
                                          gerejaField = "";
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            GestureDetector(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
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
                                "File Sertifikat",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.amber),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Baptism_Certificate_Url == ""
                                  ? const Text("Belum tersedia",
                                      style: const TextStyle(fontSize: 16))
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image(
                                        image: NetworkImage(
                                            Baptism_Certificate_Url),
                                        fit: BoxFit.fill,
                                      )),
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
