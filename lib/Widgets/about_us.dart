import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talaa5/Objects/tal\'aa.dart';
import 'package:talaa5/Objects/friends_object.dart';
import 'package:talaa5/Widgets/SideBar.dart';

import '../Objects/groups_object.dart';

class AboutUs extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  final List<Friend> _dataList;
  final List<Talaa> a;
  final List<Group> b;

  AboutUs(this._dataList, this.a, this.b);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
          backgroundColor: Colors.blueGrey,
        ),
        drawer: SideBar(_dataList, a, b),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
            ),
            child: ListView(
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Solaiman Aldokhail",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Software Engineering",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("201948730")
                      ]),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Suliman Salih",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Software Engineering",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("201947830")
                      ]),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mohammed Mashi",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Computer Science",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("201959890")
                      ]),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abdulelah Taher",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Computer Science",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("201918310")
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
