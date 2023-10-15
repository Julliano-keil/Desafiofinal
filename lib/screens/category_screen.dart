import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';

import '../data_repositories/person_controler.dart';
import '../data_repositories/vehicle_controller.dart';
import '../reusable widgets/dialog.dart';
import '../reusable widgets/horizontal_tabbar.dart';

///responsible for listing registered vehicles
class Categorys extends StatefulWidget {
  ///constructor class
  const Categorys({super.key});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  late int selectedtalbar;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context);

    final userid = state.loggedUser!.id;
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<CatergoryListController>(
      create: (context) => CatergoryListController(person: userid!),
      child: Consumer<CatergoryListController>(
        builder: (_, state, __) {
          return SafeArea(
            child: DefaultTabController(
              initialIndex: 0,
              length: 1,
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
                      child: const Column(
                        children: [
                          Horizontaltabbar(),
                          _Categoryscren(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  int getselectbarindx(int indx) {
    return indx;
  }
}

// ignore: must_be_immutable
class _Categoryscren extends StatefulWidget {
  const _Categoryscren();

  @override
  State<_Categoryscren> createState() => _CategoryscrenState();
}

class _CategoryscrenState extends State<_Categoryscren> {
  final _pagecontroler = PageController(viewportFraction: 0.75);

  double _currentpage = 0.0;
  double indexPage = 0.0;

  void _listener() {
    setState(
      () {
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
      },
    );
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
    final settings = Provider.of<Settingscode>(context);
    final state = Provider.of<PersonControler>(context);

    final userid = state.loggedUser!.id;
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<CatergoryListController>(
      create: (context) => CatergoryListController(person: userid!),
      child: Consumer<CatergoryListController>(
        builder: (_, state, __) {
          return Expanded(
            child: PageView.builder(
              controller: _pagecontroler,
              physics: const BouncingScrollPhysics(),
              itemCount: state.listCategory.length,
              itemBuilder: (context, index) {
                final car = state.listCategory[index];

                return Padding(
                  padding: EdgeInsets.only(right: index == indexPage ? 30 : 60),
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
                              color: settings.ligthMode
                                  ? Colors.amber
                                  : Colors.white),
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
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                      child: FittedBox(
                                        child: Text('Anderson\nAuto Center',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              userid != 1
                                  ? Positioned(
                                      left: size.width * 0.54,
                                      top: size.height / 100,
                                      child: PopupMenuButton<String>(
                                        onSelected: (choice) async {
                                          if (choice == 'Opção 1') {
                                            await state.delete(car);
                                          }
                                        },
                                        itemBuilder: (context) {
                                          return <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'Opção 1',
                                              child: Text('Deletar Veiculo'),
                                            ),
                                          ];
                                        },
                                      ),
                                    )
                                  : Positioned(
                                      left: 210,
                                      top: 5,
                                      child: PopupMenuButton<String>(
                                        onSelected: (choice) async {
                                          if (choice == 'Opção 1') {
                                            await state.delete(car);
                                          }
                                          if (choice == 'Opção 2' &&
                                              context.mounted) {
                                            CustomDialog.showSuccess(
                                                context,
                                                'Informação',
                                                'Esse veiculo pertence'
                                                    ' a loja ${car.nameUser} ');
                                          }
                                        },
                                        itemBuilder: (context) {
                                          return <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'Opção 1',
                                              child: Text('Deletar Veiculo'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'Opção 2',
                                              child: Text('Mais informaçoes'),
                                            ),
                                          ];
                                        },
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
                                top: size.height * 0.57,
                                right: size.height / 120,
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
                                      await Get.toNamed('/SaleVehicle',
                                          arguments: car);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(25.0),
                                      child: Text(
                                        'Vender Veiculo',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
