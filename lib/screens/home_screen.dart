import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositorio_de_dados/person_controler.dart';
import '../widgets/home_cards.dart';
import '../widgets/trasactonimage.dart';
import 'signup_scren.dart';
import 'vehicle_screen.dart';

class Home extends StatefulWidget {
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
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentIndex < image.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        setState(() {
          currentIndex = 1;
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
    final state = Provider.of<PersonControler>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    width: 420,
                    height: 352,
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
                                  return TransactionImage(
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
                                        'Holá ${state.nameuser}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ]),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ultimo login 23/07/2023 as 17:50 ',
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
                          height: 401,
                          margin: const EdgeInsets.only(bottom: 2),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(90))),
                          child: GridView(
                            padding: const EdgeInsets.all(35),
                            gridDelegate:
                                // ignore: lines_longer_than_80_chars
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
                                text: 'ultimas\ntransaçoes',
                                icon: Icons.access_time,
                                ontap: () {},
                              ),
                              Cards(
                                text: 'cadastrar \nusuarios ',
                                icon: Icons.list_alt_outlined,
                                ontap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp()));
                                },
                              ),
                              Cards(
                                  text: 'Cadastrar\n novos carros',
                                  icon: Icons.car_crash_sharp,
                                  ontap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const VehicleRegister()));
                                  })
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
    );
  }
}
