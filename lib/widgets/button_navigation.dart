import 'package:flutter/material.dart';

class Buttonnavigator extends StatelessWidget {
  final Function() onpresed;
  final String text;

  const Buttonnavigator(
      {super.key, required this.onpresed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onpresed,
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
