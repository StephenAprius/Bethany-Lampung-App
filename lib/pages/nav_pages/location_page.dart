import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: const Column(
            children: [
               Image(
                image: AssetImage("assets/gereja.png"),
                fit: BoxFit.cover,
              ),
               SizedBox(
                height: 10,
              ),
               Text(
                "Gereja Bethany Lampung",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
               SizedBox(
                height: 10,
              ),
               Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Text(
                  "Perumahan Bumi Asri Jl. Cendana III No.blok L, Kedamaian, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35122",
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(
                height: 10,
              ),
               Text(
                "+ 62 813 4372 6571",
                style: TextStyle(color: Color.fromARGB(255, 195, 160, 20),fontWeight: FontWeight.w600, fontSize: 16),
              ),
               Text(
                "Pdt. Linda Senduk",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
               SizedBox(
                height: 10,
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sabtu",
                          style: TextStyle(
                              color: Color.fromARGB(255, 195, 160, 20),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "19:00 WIB",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Youth Bethany Lampung",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Minggu",
                          style: TextStyle(
                              color: Color.fromARGB(255, 195, 160, 20),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "07:30 WIB",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 10,
                        ),
                        Text(
                          "Ibadah I & Sekolah Minggu",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "17:00 WIB",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Ibadah II & Sekolah Minggu",
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
               Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 50),
                  child: Text(
                    "Persembahan & Persepuluhan dapat ditransfer ke rekening berikut: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 66, 66, 66),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 10,
              ),
               Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Ibu Linda Senduk & Ibu Masri (Rekening Bersama)",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 10,
              ),
               Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "561.700.6316 - Bank Panin",
                      style: TextStyle(
                          color: Color.fromARGB(255, 195, 160, 20),
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
