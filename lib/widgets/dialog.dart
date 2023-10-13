import 'package:flutter/material.dart';

///class responsible for providing an editable dialog box
class CustomDialog {
  ///method that creates dialogue with text
  static void showSuccess(
      BuildContext context, String primarytext, String secondtext) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            primarytext,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Text(
            secondtext,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'ok',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
