import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'category_screen.dart';
import 'home_screen.dart';
import 'user_profile.dart';

///responsible for the navigation button and calling the zoon drawer
class Homepage extends StatefulWidget {
  ///constructor class
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              label: 'Concessionaria',
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
    );
  }

  _getBodyWidget() {
    if (_selectedIndex == 0) {
      return const Home();
    } else if (_selectedIndex == 1) {
      return const Categorys();
    } else if (_selectedIndex == 2) {
      return const ProfileUser();
    }
    return const LinearProgressIndicator();
  }
}
