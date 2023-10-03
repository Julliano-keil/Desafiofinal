import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../entidades/person.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.category});
  final Widget category;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            ),
          ),
          body: _getBodyWidget(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.white70,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.home_outlined),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.category),
                label: 'Categorias',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  _getBodyWidget() {
    final person = ModalRoute.of(context)!.settings.arguments as Person?;
    if (_selectedIndex == 0) {
      return const Home();
    } else if (_selectedIndex == 1) {
      Future.delayed(Duration.zero, () {
        return unawaited(Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('/Categry', arguments: person));
      });
      return const LinearProgressIndicator();
    } else if (_selectedIndex == 2) {
      return Settings();
    }
    return const LinearProgressIndicator();
  }
}
