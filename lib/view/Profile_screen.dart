// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return 
     const Scaffold(
      body: Center(child: Text("Profile_Screen"),),
     );
  }
}