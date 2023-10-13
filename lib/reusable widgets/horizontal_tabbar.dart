import 'package:flutter/material.dart';

///class with functionality to show text, but for future updates a filter
class Horizontaltabbar extends StatelessWidget {
  ///constructor class
  const Horizontaltabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        labelStyle: const TextStyle(fontSize: 18),
        isScrollable: true,
        indicatorPadding: const EdgeInsets.only(right: 20),
        labelPadding: const EdgeInsets.all(20),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3,
            color: Colors.white,
          ),
        ),
        tabs: ['Concessionária  ']
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(e),
                ))
            .toList());
  }
}
