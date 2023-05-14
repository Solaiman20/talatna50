import 'package:flutter/material.dart';
import 'package:talaa5/Objects/friends_object.dart';

import '../Objects/friends_object.dart';
import '../Objects/tal\'aa.dart';

class NewGroup extends StatefulWidget {
  final Function _addGroup;
  var titleController = TextEditingController();
  final List<Friend> _dataList;

  NewGroup(
    this._addGroup,
    this.titleController,
    this._dataList,
  );

  @override
  State<NewGroup> createState() => _NewTalaaState();
}

class _NewTalaaState extends State<NewGroup> {
  void _submitData() {
    final titleEntered = widget.titleController.text;
    if (titleEntered.isEmpty) {
      return;
    }
    List<Friend> _selectedDataList =
        widget._dataList.where((data) => data.isSelected).toList();
    widget._addGroup(
      titleEntered,
      _selectedDataList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Title:",
                border: OutlineInputBorder(),
              ),
              controller: widget.titleController,
              onChanged: (value) => {},
              onSubmitted: (_) {
                _submitData();
              },
            ),
            Container(
              height: 150,
              child: ListView.builder(
                itemCount: widget._dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(widget._dataList[index].userName),
                    value: widget._dataList[index].isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        widget._dataList[index].isSelected = value!;
                      });
                    },
                  );
                },
              ),
            ),
            TextButton(
                onPressed: _submitData,
                child: Text(
                  "Submit",
                ),
                style: TextButton.styleFrom(
                  primary: Colors.amber,
                ))
          ],
        ),
      ),
    );
  }
}
