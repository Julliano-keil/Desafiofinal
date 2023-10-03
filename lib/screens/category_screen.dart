import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entidades/person.dart';
import '../repositorio_de_dados/vehicle_controller.dart';

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
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
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
                      end: Alignment.bottomCenter),
                ),
                child: Column(children: [
                  Horizontaltabbar(
                    ontap: (p0) {
                      setState(() {
                        selectedtalbar = getselectbarindx(p0);
                      });
                    },
                  ),
                  Categoryscren(person: person!),
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

class Categoryscren extends StatefulWidget {
  Categoryscren({super.key, required this.person});
  Person person;
  @override
  State<Categoryscren> createState() => CategoryscrenState();
}

class CategoryscrenState extends State<Categoryscren> {
  final _pagecontroler = PageController(viewportFraction: 0.75);

  double _currentpage = 0.0;
  double indexPage = 0.0;

  void _listener() {
    setState(() {
      _currentpage = _pagecontroler.page!;

      const precision = 0.1;

      for (var i = 0; i <= 25; i++) {
        if ((_currentpage - i) < precision) {
          indexPage = i.toDouble();
          break;
        }
      }
      for (var i = 0; i < 6; i++) {
        if (_currentpage >= i.toDouble() && _currentpage <= (i + 0.7)) {
          indexPage = i.toDouble();
          break;
        }
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
    return ChangeNotifierProvider<VehicleController>(
      create: (context) => VehicleController(),
      child: Consumer<VehicleController>(
        builder: (_, state, __) {
          return Expanded(
            child: PageView.builder(
              controller: _pagecontroler,
              physics: const BouncingScrollPhysics(),
              itemCount: state.listavehicle.length,
              itemBuilder: (context, index) {
                final car = state.listavehicle[index];
                return Padding(
                  padding: EdgeInsets.only(right: index == indexPage ? 30 : 50),
                  child: Transform.translate(
                    offset: Offset(index == indexPage ? 0 : 20, 0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      car.brand.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      car.model.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        car.pricePaidShop.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
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
                                right: -constraints.maxHeight * 0.0,
                                bottom: constraints.maxHeight * 0.2,
                                child: Image.file(
                                  File(
                                    car.image!,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 502,
                                right: 1,
                                child: Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(35),
                                        topLeft: Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.of(context,
                                              rootNavigator: true)
                                          .pushReplacementNamed('/SaleVehicle',
                                              arguments: {
                                            'args': car,
                                            'args1': widget.person
                                          });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Comprar Vehiculo',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
