import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FamilyAltarDetail {
  final String name;
  final String contactName;
  final String phoneNumber;
  final String quotes;
  final String location;
  final List<String> images;

  FamilyAltarDetail({
    required this.name,
    required this.contactName,
    required this.phoneNumber,
    required this.quotes,
    required this.location,
    required this.images,
  });

  factory FamilyAltarDetail.fromJson(Map<String, dynamic> json) {
    return FamilyAltarDetail(
      name: json['name'],
      contactName: json['contact_name'],
      phoneNumber: json['phone_number'],
      quotes: json['quotes'],
      location: json['location'],
      images: [
        json['image1'],
        json['image2'],
        json['image3'],
        json['image4'],
        json['image5'],
      ],
    );
  }
}

class FaSukabumi extends StatefulWidget {
  final int idFa;
  const FaSukabumi({super.key, required this.idFa});

  @override
  State<FaSukabumi> createState() => _FaSukabumiState();
}

class _FaSukabumiState extends State<FaSukabumi> {
  late Future<FamilyAltarDetail> futureFamilyAltarDetail;
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futureFamilyAltarDetail = fetchFamilyAltarDetail(widget.idFa);
    _startAutoSlide();
  }

  Future<FamilyAltarDetail> fetchFamilyAltarDetail(int idFa) async {
    final response = await http.post(
      Uri.parse(
          'https://bethanylampung.com/services/m/family_altar_detail.php'),
      body: {'id_fa': idFa.toString()},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == 1) {
        return FamilyAltarDetail.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to load data: success != 1');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_activePage < _pageController.page!.toInt() + 1) {
          _activePage++;
        } else {
          _activePage = 0;
        }
        _pageController.animateToPage(
          _activePage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildCarousel(List<String> imagePaths) {
    // Filter out empty or null image paths
    List<String> validImagePaths =
        imagePaths.where((path) => path.isNotEmpty).toList();

    // Check if there are valid images to display
    if (validImagePaths.isEmpty) {
      return const SizedBox(
        height: 200.0,
        child: Center(
          child: Text('No images available'),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: 200.0,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: validImagePaths.length,
            onPageChanged: (index) {
              setState(() {
                _activePage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                validImagePaths[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 200),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(validImagePaths.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor:
                        _activePage == index ? Colors.yellow : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
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
        title: const Text("Family Altar Detail"),
      ),
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: FutureBuilder<FamilyAltarDetail>(
        future: futureFamilyAltarDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final faDetail = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildCarousel(faDetail.images),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          faDetail.quotes,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 81, 81, 81),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          faDetail.name,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text(
                          faDetail.location,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 94, 94, 94),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          faDetail.phoneNumber,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 195, 160, 20),
                            fontSize: 18,
                            fontWeight: FontWeight.w600
        
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          faDetail.contactName,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
