import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jscar/screens/sales_report_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'casos_de_usos/autonomy_data.dart';
import 'repositorio_de_dados/person_controler.dart';
import 'repositorio_de_dados/profile_controller.dart';
import 'screens/autonomy_screen.dart';
import 'screens/botton_navigator_bar.dart';
import 'screens/category_screen.dart';

import 'screens/edit_person_screen.dart';
import 'screens/registered_people_screen.dart';
import 'screens/sale_vehicle_register_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/signup_scren.dart';
import 'screens/vehicle_register_screen.dart';
import 'widgets/zoondrauwer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PersonControler>(
          create: (context) => PersonControler(),
        ),
        ChangeNotifierProvider<ProfileController>(
          create: (context) => ProfileController(personid: 0),
        ),
        ChangeNotifierProvider<AutonomyProvider>(
          create: (context) => AutonomyProvider([]),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  double imageSize = 100.0;
  bool isZoomed = false;

  void initializeSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    navigateToHomepage();
  }

  void navigateToHomepage() {
    unawaited(navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn())));
  }

  @override
  void initState() {
    super.initState();
    initializeSplash();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/MyApp': (context) => const MyApp(),
        '/Homepage': (context) => const Zoom(mainScreen: Homepage()),
        '/Category': (context) => const Categorys(),
        '/Settings': (context) => Settings(),
        '/SignUp': (context) => const SignUp(),
        '/SignIn': (context) => const SignIn(),
        '/Registerpeople': (context) => Zoom(mainScreen: Registeredpeople()),
        '/Autonomyedite': (context) => const Autonomyedite(),
        '/EditPerson': (context) => EditPerson(),
        // '/RegisteredAutonomy': (context) => RegisteredAutonomy(),
        '/SaleVehicle': (context) => const SaleVehicle(),
        'VehicleRegister': (context) => const VehicleRegister(),
        'SalesReport': (context) => SalesReport()
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Center(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: FadeTransition(
              opacity: _animation,
              child: Center(
                child: Image.asset('imagens/logoEd.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
