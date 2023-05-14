import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talaa5/Widgets/about_us.dart';
import 'package:talaa5/Widgets/friends.dart';
import 'package:talaa5/Widgets/groups.dart';
import 'package:talaa5/Widgets/requests.dart';
import 'package:talaa5/main.dart';
import '../Objects/bills.dart';
import '../Objects/friends_object.dart';
import '../Objects/groups_object.dart';
import '../Objects/tal\'aa.dart';
import './home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Bills.dart';
import 'package:image_picker/image_picker.dart';

class SideBar extends StatefulWidget {
  final List<Friend> _dataList;
  final List<Talaa> a;
  final List<Group> b;
  SideBar(this._dataList, this.a, this.b);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final user = FirebaseAuth.instance.currentUser;

  File? _imageFile;
  final List<Bill> c = [
    Bill(
        "500",
        Talaa(
            "2023-04-15",
            [
              Friend("Mohammed", "le@gmail.com", "SA8288484883", false),
              Friend("Ahmed", "ahmed@gmail.com", "SA680000243568", false)
            ],
            "Dammam",
            "cafe")),
    Bill(
      "800",
      Talaa(
          "1989-07-28",
          [
            Friend("Khaled", "example@gmail.com", "SA828282983", false),
            Friend("Naser", "e@gmail.com", "SA68000028288", false)
          ],
          "Riyadh",
          "kashta"),
    ),
  ];

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.blueGrey.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Hello it is me"),
              accountEmail: Text(user!.email!),
              currentAccountPicture: CircleAvatar(
                child: GestureDetector(
                  onTap: _getImage,
                  child: ClipOval(
                    child: Image.network(
                      _imageFile?.path ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZNw-Xb72bT1CdUmNoV1ywDbQTQ22IcUTjOw&usqp=CAU",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1483232539664-d89822fb5d3e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvdG8lMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text("Tal'at"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(widget._dataList, widget.a, widget.b)));
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text("Friends"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Friends(widget._dataList, widget.a, widget.b)));
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text("Groups"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Groups(widget._dataList, widget.a, widget.b)));
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text("Bills"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Bills(widget._dataList, widget.a, widget.b, c)));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Requests"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Requests(widget._dataList, widget.a, widget.b)));
              },
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Us"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AboutUs(widget._dataList, widget.a, widget.b)));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign Out"),
              onTap: () {
                // FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ));
  }
}
