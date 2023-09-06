import 'package:flutter/material.dart';

class CustomDialog {
  static void showSuccess(
      BuildContext context, String primarytext, String secondtext) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            primarytext,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            secondtext,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.black,
                ))
          ],
        );
      },
    );
  }
}
