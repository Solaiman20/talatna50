import 'package:firebase_auth/firebase_auth.dart';

import './Widgets/home_page.dart';
import './Widgets/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Objects/friends_object.dart';
import 'Objects/groups_object.dart';
import 'Objects/tal\'aa.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final List<Talaa> a = [
    Talaa(
        "1989-07-28",
        [
          Friend("Khaled", "example@gmail.com", "SA828282983", false),
          Friend("Naser", "e@gmail.com", "SA68000028288", false)
        ],
        "Riyadh",
        "kashta"),
    Talaa(
        "2023-04-15",
        [
          Friend("Mohammed", "le@gmail.com", "SA8288484883", false),
          Friend("Ahmed", "ahmed@gmail.com", "SA680000243568", false)
        ],
        "Dammam",
        "cafe")
  ];
  final List<Friend> _dataList = [
    Friend("Khaled", "example@gmail.com", "SA828282983", false),
    Friend("Naser", "e@gmail.com", "SA68000028288", false),
    Friend("Mohammed", "le@gmail.com", "SA8288484883", false),
    Friend("Ahmed", "ahmed@gmail.com", "SA680000243568", false),
  ];
  final List<Group> b = [
    Group([
      Friend("Khaled", "example@gmail.com", "SA828282983", false),
      Friend("Naser", "e@gmail.com", "SA68000028288", false),
    ], "Riyadh guys"),
    Group([
      Friend("Mohammed", "le@gmail.com", "SA8288484883", false),
      Friend("Ahmed", "ahmed@gmail.com", "SA680000243568", false),
    ], "Khobar boys")
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: "Tal'atna",
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage(_dataList, a, b);
              } else {
                return SignInPage();
              }
            }),
      ),
    );
  }
}
