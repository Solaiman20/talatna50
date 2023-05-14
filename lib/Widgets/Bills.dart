import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talaa5/Widgets/SideBar.dart';

import '../Objects/bills.dart';
import '../Objects/friends_object.dart';
import '../Objects/groups_object.dart';
import '../Objects/tal\'aa.dart';
import '../Widgets/newBill.dart';

class Bills extends StatefulWidget {
  final List<Friend> _dataList;
  final List<Talaa> a;
  final List<Group> b;
  final List<Bill> c;
  Bills(this._dataList, this.a, this.b, this.c);

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  final user = FirebaseAuth.instance.currentUser;

  Bill? selectedBill;

  final titleController = TextEditingController();

  void addBill(String title, Talaa b) {
    final newtx = Bill(title, b);
    setState(() {
      widget.c.add(newtx);
    });
  }

  void _startAddNewBill(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => _startAddNewBill(ctx),
          child: NewBill(addBill, titleController, widget.a),
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
          title: Text("Bills"),
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
                      itemCount: widget.c.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selectedBill = widget.c[index];
                                });
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    widget.c.removeAt(index);
                                  });
                                },
                              ),
                              leading: const Icon(Icons.list),
                              title: Text(
                                widget.c[index].talaa.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ));
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
                              Text("The Name of the Talaa:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedBill?.talaa.name ?? "",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("The amount of the bill:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text(selectedBill?.amount ?? "",
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
                                  selectedBill?.talaa.friends
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
          onPressed: () => _startAddNewBill(context),
        ),
      ),
    );
  }
}
