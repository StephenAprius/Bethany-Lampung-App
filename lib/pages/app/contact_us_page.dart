import 'package:bethany_app/components/my_card.dart';

import 'package:bethany_app/pages/app/fa_sukabumi.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
        title: const Text("Contact Us"),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
