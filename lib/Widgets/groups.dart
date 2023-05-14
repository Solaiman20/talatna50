import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talaa5/Widgets/SideBar.dart';
import 'package:talaa5/Widgets/newGroup.dart';
import '../Objects/bills.dart';
import '../Objects/groups_object.dart';

import '../Objects/friends_object.dart';
import '../Objects/tal\'aa.dart';

class Groups extends StatefulWidget {
  final List<Friend> _dataList;
  final List<Talaa> a;
  final List<Group> b;

  Groups(this._dataList, this.a, this.b);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final user = FirebaseAuth.instance.currentUser;
  Group? selectedGroup;

  final titleController = TextEditingController();

  final locationController = TextEditingController();

  Future addGroup(String title, List<Friend> b) async {
    final docUser = FirebaseFirestore.instance.collection("groups");
    final c = Map.fromIterable(b,
        key: (e) => e.userName, value: (e) => [e.email, e.iban]);
    final json = {"friends": c, "title": title};
    final newtx = Group(b, title);
    await docUser.add(json);
    setState(() {
      widget.b.add(newtx);
    });
  }

  void _startAddNewTalaa(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => _startAddNewTalaa(ctx),
          child: NewGroup(addGroup, titleController, widget._dataList),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Groups"),
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
                      itemCount: widget.b.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedGroup = widget.b[index];
                              });
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  widget.b.removeAt(index);
                                });
                              },
                            ),
                            leading: const Icon(Icons.list),
                            title: Text(
                              widget.b[index].title,
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
                              Text("The Name:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedGroup?.title ?? "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Friends: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  selectedGroup?.friends
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
