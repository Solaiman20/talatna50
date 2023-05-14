import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talaa5/Widgets/SideBar.dart';

import '../Objects/friends_object.dart';
import '../Objects/groups_object.dart';
import '../Objects/tal\'aa.dart';

class Requests extends StatefulWidget {
  final List<Friend> _dataList;
  final List<Talaa> a;
  final List<Group> b;

  Requests(this._dataList, this.a, this.b);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final user = FirebaseAuth.instance.currentUser;

  final List<Talaa> b = [
    Talaa(
        "2023-05-01",
        [
          Friend("Khaled", "example@gmail.com", "SA828282983", false),
          Friend("Naser", "e@gmail.com", "SA68000028288", false)
        ],
        "Riyadh",
        "Boulivard city"),
    Talaa(
        "2023-04-23",
        [
          Friend("Mohammed", "le@gmail.com", "SA8288484883", false),
          Friend("Ahmed", "ahmed@gmail.com", "SA680000243568", false)
        ],
        "Dammam",
        "The corniche")
  ];
  bool isvisible1 = true;
  bool isvisible2 = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Requests"),
          backgroundColor: Colors.blueGrey,
        ),
        drawer: SideBar(
          widget._dataList,
          widget.a,
          widget.b,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
          ),
          child: Column(children: [
            Visibility(
              visible: isvisible1,
              child: Card(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                          "Nasser is inviting you to a tal'aa named ${b[0].name} in ${b[0].location}"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.a.add(b[0]);
                                  isvisible1 = false;
                                });
                              },
                              icon: Icon(Icons.check)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isvisible1 = false;
                                });
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isvisible2,
              child: Card(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                          "Ahmed is inviting you to a tal'aa named ${b[1].name} in ${b[1].location}"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.a.add(b[1]);
                                  isvisible2 = false;
                                });
                              },
                              icon: Icon(Icons.check)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isvisible2 = false;
                                });
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
