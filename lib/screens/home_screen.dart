import 'dart:async';

import 'package:flutter/material.dart';

import 'package:jscar/screens/maindrawer.dart';
import 'package:jscar/screens/singup_scren.dart';
import 'package:jscar/widgets/home_cards.dart';

import '../widgets/trasactonimage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imageUrls = [
    'https://assets-cdn.static-gm.com/Assets/a646d2ba-887d-4fcc-8e51-87fdcfec8da4/14538a9d-cc9c-44c3-a110-410d1c4d2639/v-1643915900/Desktop.webp',
    'https://assets-cdn.static-gm.com/Assets/a646d2ba-887d-4fcc-8e51-87fdcfec8da4/14538a9d-cc9c-44c3-a110-410d1c4d2639/v-1643915900/Desktop.webp',
    'https://assets-cdn.static-gm.com/Assets/a646d2ba-887d-4fcc-8e51-87fdcfec8da4/14538a9d-cc9c-44c3-a110-410d1c4d2639/v-1643915900/Desktop.webp',
    'https://assets-cdn.static-gm.com/Assets/a646d2ba-887d-4fcc-8e51-87fdcfec8da4/14538a9d-cc9c-44c3-a110-410d1c4d2639/v-1643915900/Desktop.webp',
  ];

  int currentIndex = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentIndex < imageUrls.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        setState(() {
          currentIndex = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String nome = 'Juliano';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const MainDrawer(),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.black,
              child: Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  color: Colors.amber,
                  // color: const Color.fromARGB(255, 247, 234, 234),
                  child: Column(
                    children: [
                      Container(
                        width: 420,
                        height: 350,
                        margin: const EdgeInsets.only(bottom: 0),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(130))),
                        child: ListView(
                            padding: EdgeInsets.zero,
                            //carrossel
                            children: [
                              Container(
                                  color: Colors.black,
                                  width: 420,
                                  height: 180,
                                  child: PageView.builder(
                                    controller: PageController(
                                        initialPage: currentIndex,
                                        viewportFraction: 0.9),
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return TransactionImage(
                                        imageUrl: imageUrls[index],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Olà $nome',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                        ]),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ultimo login 23/07/2023 as 17:50',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                      Container(
                        color: Colors.black,
                        child: Column(
                          children: [
                            Container(
                              width: 420,
                              height: 571,
                              margin: const EdgeInsets.only(bottom: 2),
                              decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  // color: Color.fromARGB(255, 247, 234, 234),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(90))),
                              child: GridView(
                                padding: const EdgeInsets.all(35),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 4 / 3,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 25,
                                ),
                                children: [
                                  Cards(
                                    text: 'Relatorio \nde vendas ',
                                    icon: Icons.wallet,
                                    ontap: () {},
                                  ),
                                  Cards(
                                    text: 'ultimas\n transaçoes',
                                    icon: Icons.access_time,
                                    ontap: () {},
                                  ),
                                  Cards(
                                    text: 'cadastrar \n usuarios ',
                                    icon: Icons.list_alt_outlined,
                                    ontap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ));
                                    },
                                  ),
                                  Cards(
                                    text: 'Cadastrar\n novos carros',
                                    icon: Icons.car_crash_sharp,
                                    ontap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
