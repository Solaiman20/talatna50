import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:talaa5/Objects/friends_object.dart';

import '../Objects/tal\'aa.dart';

class NewTalaa extends StatefulWidget {
  final Function _addTalaa;
  var titleController = TextEditingController();
  var locationController = TextEditingController();
  final List<Friend> _dataList;
  final List<Talaa> a;

  NewTalaa(
    this._addTalaa,
    this.titleController,
    this.locationController,
    this._dataList,
    this.a,
  );

  @override
  State<NewTalaa> createState() => _NewTalaaState();
}

class _NewTalaaState extends State<NewTalaa> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitData() {
    final titleEntered = widget.titleController.text;
    final locationEntered = widget.locationController.text;
    if (titleEntered.isEmpty || locationEntered.isEmpty) {
      return;
    }
    List<Friend> _selectedDataList =
        widget._dataList.where((data) => data.isSelected).toList();
    widget._addTalaa(
      titleEntered,
      _selectedDataList,
      locationEntered,
      DateFormat('yyyy-MM-dd').format(selectedDate).toString() +
          selectedTime.format(context).toString(),
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
            TextField(
              decoration: InputDecoration(
                labelText: "Location:",
                border: OutlineInputBorder(),
              ),
              controller: widget.locationController,
              onSubmitted: (_) {
                _submitData();
              },
            ),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Select date'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text('Select time'),
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
