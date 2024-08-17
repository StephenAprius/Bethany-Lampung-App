import 'package:bethany_app/components/my_app.dart';
import 'package:bethany_app/pages/app/baptis_page.dart';
import 'package:bethany_app/pages/app/contact_us_page.dart';
import 'package:bethany_app/pages/app/doa_konseling_page.dart';
import 'package:bethany_app/pages/app/family_page.dart';
import 'package:bethany_app/pages/app/pernikahan_pria.dart';
import 'package:bethany_app/pages/app/contact_us_page.dart';
import 'package:bethany_app/pages/nav_pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  String nij = "";
  List<String> userInfo = [];

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userInfo = prefs.getStringList('userInfo') ?? [];
      if (userInfo.isNotEmpty) {
        nij = userInfo[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
        body: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "Bethany App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height /8,
                child: MyApp(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const DoaPage()));
                  },
                  name: "Doa & Konseling",
                  imagePath: "assets/pray.png",
                  isVisible: true,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 8,
                child: MyApp(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const FamilyPage()));
                  },
                  name: "Family Altar",
                  imagePath: "assets/bible.png",
                  isVisible: true,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 8,
                child: MyApp(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PernikahanPriaPage()));
                  },
                  name: "Pernikahan",
                  imagePath: "assets/blackboard.png",
                  isVisible: nij == "" ? false : true,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 8,
                child: MyApp(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const BaptisPage()));
                  },
                  name: "Baptisan",
                  imagePath: "assets/blackboard.png",
                  isVisible: nij == "" ? false : true,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Row(
            children: [
              Text(
                "Informasi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 8,
                child: MyApp(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ContactUsPage()));
                  },
                  name: "Kontak Kami",
                  imagePath: "assets/pray.png",
                  isVisible: true,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 8,
                child: MyApp(
                  onTap: () async {
                    const url = 'https://successfulbethanyfamilies.org/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  name: "Bethany Nginden",
                  imagePath: "assets/pray.png",
                  isVisible: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    ));
  }
}
