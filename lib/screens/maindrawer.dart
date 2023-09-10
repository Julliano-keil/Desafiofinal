import 'package:flutter/material.dart';
import 'botton_navigator_bar.dart';
import 'registered_people_screen.dart';
import 'settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 2, 2, 2),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(
                  255, 0, 0, 0), // Cor de fundo do cabeçalho do Drawer
              child: Image.asset(
                'imagens/logojk.png',
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              iconColor: Colors.amber,
              title: const Text(
                'Página Inicial',
                style: TextStyle(color: Colors.amber),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Homepage())); // Fechar o Drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              iconColor: Colors.amber,
              title: const Text(
                'Configurações',
                style: TextStyle(color: Colors.amber),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_alt_outlined),
              iconColor: Colors.amber,
              title: const Text(
                'Lista de associados',
                style: TextStyle(color: Colors.amber),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Registeredpeople()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
