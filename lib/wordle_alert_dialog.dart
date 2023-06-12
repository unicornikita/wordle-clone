import 'package:flutter/material.dart';

class WordleAlertDialog extends StatelessWidget {
  final String title;
  final String text;
  final String correctWord;
  const WordleAlertDialog({Key? key, required this.title, required this.text, required this.correctWord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(text + correctWord),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Play Again'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
