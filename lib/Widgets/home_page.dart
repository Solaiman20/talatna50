import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Objects/friends_object.dart';
import '../Objects/groups_object.dart';
import '../Objects/tal\'aa.dart';
import './SideBar.dart';
import 'new_talaa.dart';

class HomePage extends StatefulWidget {
  final List<Friend> _dataList;
  List<Talaa> a;
  final List<Group> b;

  HomePage(this._dataList, this.a, this.b);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  Talaa? selectedTalaa;

  final titleController = TextEditingController();

  final locationController = TextEditingController();

  Future addTalaa(
      String title, List<Friend> b, String location, String dateTime) async {
    final docUser = FirebaseFirestore.instance.collection("Talaa");
    final c = Map.fromIterable(b,
        key: (e) => e.userName, value: (e) => [e.email, e.iban]);
    final json = {
      "date": dateTime,
      "friends": c,
      "location": location,
      "name": title
    };
    final tx = Talaa(dateTime, b, location, title);
    await docUser.add(json);
    print("success");
    setState(() {
      widget.a.add(tx);
    });
  }

  void _startAddNewTalaa(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => _startAddNewTalaa(ctx),
          child: NewTalaa(addTalaa, titleController, locationController,
              widget._dataList, widget.a),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Set<Friend> selectedItems = Set<Friend>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tal'aat"),
          backgroundColor: Colors.blueGrey,
        ),
        drawer: SideBar(widget._dataList, widget.a, widget.b),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.a.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedTalaa = widget.a[index];
                              });
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  widget.a.removeAt(index);
                                });
                              },
                            ),
                            leading: const Icon(Icons.list),
                            title: Text(
                              widget.a[index].name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 5,
                  child: Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("The Name: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedTalaa?.name ?? "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Location: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedTalaa?.location ?? "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Date and time: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedTalaa?.date ?? "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Friends coming: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  selectedTalaa?.friends
                                          .map((f) => f.userName)
                                          .join(", ") ??
                                      "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTalaa(context),
        ),
      ),
    );
  }
}
