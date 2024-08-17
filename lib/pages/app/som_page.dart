import 'package:flutter/material.dart';

class SOMPage extends StatefulWidget {
  const SOMPage({super.key});

  @override
  State<SOMPage> createState() => _SOMPage();
}

class _SOMPage extends State<SOMPage> {
  int kelas = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Sekolah Orientasi Melayani"),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Pendaftaran Kelas",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text("Kelas belum tersedia"),
                  ],
                ),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Keselamatan'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Keselamatan'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('Keselamatan'),
                                  ),
                                ],
                                value: kelas,
                                onChanged: (value) {
                                  setState(() {
                                    kelas = value!;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors
                                      .black, // Adjust the color as needed
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Kelas akan dilaksanakan setiap '),
                                  TextSpan(
                                    text: 'selasa',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' pukul '),
                                  TextSpan(
                                    text: '19.00',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' WIB di '),
                                  TextSpan(
                                    text: 'Gereja Bethany Lampung lt.2',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text("Riwayat kelulusan kelas"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: const Text("Keselamatan")),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text("SOM Periode 02 - 2018")),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: const Text(
                                        "View Certificate",
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      )),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Text Clicked")));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: const Text("Holy Spirit")),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text("SOM Periode 02 - 2018")),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: const Text(
                                        "View Certificate",
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      )),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Text Clicked")));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
