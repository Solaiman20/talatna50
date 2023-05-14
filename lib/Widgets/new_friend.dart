import 'package:flutter/material.dart';

class NewFriend extends StatelessWidget {
  final Function _addFriend;
  var titleController = TextEditingController();
  var emailController = TextEditingController();
  var ibanController = TextEditingController();

  NewFriend(this._addFriend, this.titleController, this.emailController,
      this.ibanController);
  void _submitData() {
    final titleEntered = titleController.text;
    final emailEntered = emailController.text;
    final ibanEntred = ibanController.text;
    if (titleEntered.isEmpty || emailEntered.isEmpty || ibanEntred.isEmpty) {
      return;
    }
    _addFriend(
      titleEntered,
      emailEntered,
      ibanEntred,
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
              controller: titleController,
              onChanged: (value) => {},
              onSubmitted: (_) {
                _submitData();
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Email:",
                border: OutlineInputBorder(),
              ),
              controller: emailController,
              onSubmitted: (_) {
                _submitData();
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "IBAN:",
                border: OutlineInputBorder(),
              ),
              controller: ibanController,
              onSubmitted: (_) {
                _submitData();
              },
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
