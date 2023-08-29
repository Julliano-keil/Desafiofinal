import 'package:flutter/material.dart';

class Horizontaltabbar extends StatelessWidget {
  const Horizontaltabbar({
    super.key,
    required this.ontap,
  });

  final Function(int) ontap;

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
        )),
        onTap: ontap,
        tabs: ['CLASSICOS', 'ESPORTIVOS', 'CAMIONETES']
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(e),
                ))
            .toList());
  }
}
