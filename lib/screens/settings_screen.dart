import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../casos_de_usos/settings_code.dart';

///class responsible for configuring the application's theme change
class Settings extends StatelessWidget {
  ///constructor class
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settingscode>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          title: const Center(
            child: Text('Configuraçoes'),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 10, 10, 10),
                width: 430,
                height: 400,
                child: Container(
                  width: 420,
                  height: 382,
                  decoration: BoxDecoration(
                      color: settings.ligthMode ? Colors.amber : Colors.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(200))),
                  child: const _SettingsWidhts(), //           <= Configuraçoes
                ),
              ),
              Positioned(
                top: 400,
                child: Container(
                  color: settings.ligthMode ? Colors.amber : Colors.white,
                  width: 430,
                  height: 411,
                  child: Container(
                    width: 420,
                    height: 400,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(150))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsWidhts extends StatefulWidget {
  const _SettingsWidhts({Key? key}) : super(key: key);

  @override
  __SettingsWidhtsState createState() => __SettingsWidhtsState();
}

class __SettingsWidhtsState extends State<_SettingsWidhts> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settingscode>(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 15,
                  shadowColor: Colors.purple,
                  child: Row(
                    children: [
                      const Text(
                        '  Mudar para tema padrão   ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: settings.toggleTheme,
                        icon: Icon(
                          settings.ligthMode
                              ? Icons.toggle_off_outlined
                              : Icons.toggle_on_outlined,
                        ),
                        iconSize: 45,
                        visualDensity: const VisualDensity(horizontal: 1.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
