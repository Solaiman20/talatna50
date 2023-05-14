import 'package:flutter/material.dart';
import '../Objects/tal\'aa.dart';

class NewBill extends StatefulWidget {
  final Function _addBill;
  var titleController = TextEditingController();
  final List<Talaa> a;

  NewBill(
    this._addBill,
    this.titleController,
    this.a,
  );

  @override
  State<NewBill> createState() => _NewTalaaState();
}

class _NewTalaaState extends State<NewBill> {
  Talaa? selectedTalaa;
  void _submitData() {
    final titleEntered = widget.titleController.text;
    if (titleEntered.isEmpty) {
      return;
    }
    widget._addBill(titleEntered, selectedTalaa);
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
                labelText: "Amount:",
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
                itemCount: widget.a.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile<Talaa>(
                    title: Text(widget.a[index].name),
                    value: widget.a[index],
                    groupValue: selectedTalaa,
                    onChanged: (Talaa? value) {
                      setState(() {
                        selectedTalaa = value;
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
