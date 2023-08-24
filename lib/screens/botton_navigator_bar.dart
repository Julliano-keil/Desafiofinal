import 'package:flutter/material.dart';
import 'package:jscar/Screens/maindrawer.dart';
import 'package:jscar/screens/category_screen.dart';
import 'package:jscar/screens/home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
          drawer: const MainDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.black,
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

  Widget _getBodyWidget() {
    if (_selectedIndex == 0) {
      return const Home();
    } else if (_selectedIndex == 1) {
      return const Category();
    } else if (_selectedIndex == 2) {
      return const Category();
    }
    return Container(); // Retorna um container vazio se o índice for inválido.
  }
}
