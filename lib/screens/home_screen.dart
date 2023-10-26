import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../casos_de_usos/settings_code.dart';
import '../data_repositories/person_controler.dart';
import 'latest_transactions_screen.dart';
import 'vehicle_register_screen.dart';

/// main screen where the user sees registration options
class Home extends StatefulWidget {
  /// constructor class
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> image = [
    'imagens/image_carro.png',
    'imagens/image_carro.png',
    'imagens/image_carro.png'
  ];

  int currentIndex = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (currentIndex < image.length - 1) {
          setState(() {
            currentIndex++;
          });
        } else {
          setState(
            () {
              currentIndex = 1;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PersonControler>(context);
    final username = state.loggedUser!.storeName;
    final userid = state.loggedUser!.id;
    final settings = Provider.of<Settingscode>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0),
                color: settings.ligthMode ? Colors.amber : Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.39,
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(130))),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        //                                             carrossel
                        children: [
                          Container(
                              color: Colors.black,
                              width: 420,
                              height: 180,
                              child: PageView.builder(
                                controller: PageController(
                                    initialPage: currentIndex,
                                    viewportFraction: 0.9),
                                itemCount: image.length,
                                itemBuilder: (context, index) {
                                  return _TransactionImage(
                                    imageUrl: image[index],
                                    onTap: () {},
                                    width: 350,
                                    height: 160,
                                  );
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Olá $username',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ultimo login '
                                      // ignore: lines_longer_than_80_chars
                                      '${state.dataTimeNow?.split(':').sublist(0, 2).join(':')}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Container(
                            width: size.width / 0,
                            height: size.height * 0.46,
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                                color: settings.ligthMode
                                    ? Colors.amber
                                    : Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(90))),
                            child: GridView(
                              padding: const EdgeInsets.all(35),
                              gridDelegate:
                                  // ignore: lines_longer_than_80_chars
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 4 / 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              children: [
                                _Cards(
                                  text: 'Relatorio \nde vendas ',
                                  icon: Icons.wallet,
                                  ontap: () async {
                                    await Get.toNamed('SalesReport');
                                  },
                                ),
                                _Cards(
                                  text: 'ultimas\ntransaçoes',
                                  icon: Icons.access_time,
                                  ontap: () async {
                                    await Get.to(const Latesttransactions());
                                  },
                                ),
                                userid == 1
                                    ? _Cards(
                                        text: 'cadastrar \nusuarios ',
                                        icon: Icons.list_alt_outlined,
                                        ontap: () async {
                                          await Get.toNamed('/SignUp');
                                        },
                                      )
                                    : Container(),
                                userid == 1
                                    ? _Cards(
                                        text: 'Cadastrar\n novos carros',
                                        icon: Icons.car_crash_sharp,
                                        ontap: () async {
                                          await Get.toNamed('VehicleRegister');
                                        },
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              userid != 1
                  ? Positioned(
                      top: 500,
                      right: 13,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width: size.width * 0.83,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: _Cards(
                            text: ' Cadastrar\n novos carros',
                            icon: Icons.car_crash_sharp,
                            ontap: () async {
                              await Get.to(const VehicleRegister());
                            },
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  final String text;
  final IconData? icon;

  final Function() ontap;

  const _Cards({required this.text, this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SafeArea(
        child: Card(
          borderOnForeground: true,
          elevation: 20,
          shadowColor: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  icon,
                  size: 40,
                  shadows: const [Shadow(blurRadius: 5)],
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Function() onTap;

  const _TransactionImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'imagens/image_carro.png',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
