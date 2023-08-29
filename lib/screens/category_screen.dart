import 'package:flutter/material.dart';
import '../widgets/category.dart';

import '../widgets/horizontal_tabbar.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String selectedtalbar = 'CLASSICOS';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                clipBehavior: Clip.none,
                width: size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(children: [
                  Horizontaltabbar(
                    ontap: (p0) {
                      setState(() {
                        selectedtalbar = getselectbarindx(p0);
                      });
                    },
                  ),
                  const Categoryscren(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getselectbarindx(int indx) {
    switch (indx) {
      case 0:
        return 'CLASSICOS';
      case 1:
        return 'ESPORTIVOS';
      case 2:
        return 'CAMIONETES';
      default:
        return 'CLASSICOS';
    }
  }
}
