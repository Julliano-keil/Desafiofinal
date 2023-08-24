import 'package:flutter/material.dart';
import 'package:jscar/casos_de_usos/car.dart';

class Categoryscren extends StatefulWidget {
  const Categoryscren({
    super.key,
  });
  @override
  State<Categoryscren> createState() => _CategoryscrenState();
}

class _CategoryscrenState extends State<Categoryscren> {
  final _pagecontroler = PageController(viewportFraction: 0.75);

  double _currentpage = 0.0;
  double indexPage = 0.0;

  void _listener() {
    setState(() {
      _currentpage = _pagecontroler.page!;
      if (_currentpage >= 0 && _currentpage < 1.7) {
        indexPage = 0;
      } else if (_currentpage > 0.5 && -_currentpage < 1.7) {
        indexPage = 1;
      } else if (_currentpage > 1.7 && -_currentpage < 2.7) {
        indexPage = 3;
      }
    });
  }

  @override
  void initState() {
    _pagecontroler.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pagecontroler,
        physics: const BouncingScrollPhysics(),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Padding(
            padding: EdgeInsets.only(right: index == indexPage ? 30 : 50),
            child: Transform.translate(
              offset: Offset(index == indexPage ? 0 : 20, 0),
              child: LayoutBuilder(builder: (context, constraints) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(
                      top: index == indexPage ? 30 : 50, bottom: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.amber),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              car.tipo,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              car.name,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                                child: Text(
                              car.price,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )),
                            const SizedBox(
                              width: 4,
                              child: FittedBox(
                                child: Text('JK \n Automoveis',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.3,
                        left: -constraints.maxHeight * 0.0,
                        right: -constraints.maxHeight * 0.1,
                        bottom: constraints.maxHeight * 0.2,
                        child: Image.asset(
                          'imagens/mustang.png',
                          width: constraints.maxWidth +
                              constraints.maxHeight * 0.3,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
