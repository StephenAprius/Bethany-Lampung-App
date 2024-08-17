import 'package:bethany_app/pages/nav_pages/app_page.dart';
import 'package:bethany_app/pages/nav_pages/home_page.dart';
import 'package:bethany_app/pages/nav_pages/location_page.dart';
import 'package:bethany_app/pages/nav_pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const AppPage(),
    const LocationPage(),
    const ProfilePage()
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                      title: const Text('Keluar Aplikasi?'),
                      content:
                          const Text('Apakah Anda ingin keluar dari aplikasi?'),
                      actions: [
                        TextButton(
                          child: const Text('Iya'),
                          onPressed: () => SystemNavigator.pop(),
                        ),
                        TextButton(
                          child: const Text('Tidak'),
                          onPressed: () => Navigator.pop(c, false),
                        ),
                      ]));
          return false;
        },
        child: Scaffold(
           backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 236, 236,
                      236), // Change this to your desired outline color
                    width:
                        1.0, // Adjust this to your preferred outline thickness
                  ),
                ),
              ),
              child: AppBar(
                backgroundColor:  Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: pages[currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 236, 236,
                      236), // Change this to your desired outline color
                  width: 1.0, // Adjust this to your preferred outline thickness
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              onTap: onTap,
              currentIndex: currentIndex,
              selectedItemColor: const Color.fromARGB(255, 195, 160, 20),
              unselectedItemColor: Colors.grey.withOpacity(0.5),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: "Church App"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on), label: "Location"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          ),
        ));
  }
}
