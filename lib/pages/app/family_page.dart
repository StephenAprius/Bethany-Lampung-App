import 'dart:convert';
import 'package:bethany_app/components/my_card.dart';

import 'package:bethany_app/pages/app/fa_sukabumi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FamilyAltar {
  final int id;
  final String name;
  final String image;

  FamilyAltar({required this.id, required this.name, required this.image});

  factory FamilyAltar.fromJson(Map<String, dynamic> json) {
    return FamilyAltar(
      id: json['id_fa'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class MyCard extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String imagePath;

  const MyCard({
    Key? key,
    required this.onTap,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(7), // Apply border radius to the card
        ),
        elevation: 2,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                      7)), // Clip the image to match the card's border radius
              child: Image.network(
                imagePath,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(text,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // Truncate with '...'
                  maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyPageState extends State<FamilyPage> {
  late Future<List<FamilyAltar>> futureFamilyAltars;

  @override
  void initState() {
    super.initState();
    futureFamilyAltars = fetchFamilyAltars();
  }

  Future<List<FamilyAltar>> fetchFamilyAltars() async {
    final response = await http.get(
      Uri.parse('https://bethanylampung.com/services/m/family_altar_list.php'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == 1) {
        final List<dynamic> dataList = jsonData['data'];
        return dataList.map((data) => FamilyAltar.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load data: success != 1');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Family Altar"),
      ),
      backgroundColor:  const Color.fromARGB(255, 243, 243, 243),
      body: FutureBuilder<List<FamilyAltar>>(
        future: futureFamilyAltars,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final familyAltars = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: familyAltars.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.25, // Adjust as per design
                ),
                itemBuilder: (context, index) {
                  final fa = familyAltars[index];
                  return MyCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FaSukabumi(idFa: fa.id),
                        ),
                      );
                    },
                    text: fa.name,
                    imagePath: fa.image,
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
