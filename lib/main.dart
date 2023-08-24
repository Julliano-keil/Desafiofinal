import 'package:flutter/material.dart';

import 'package:jscar/screens/singin_screen.dart';

void main() {
  runApp(const MyApp());
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
    await Future.delayed(const Duration(seconds: 5));
    navigateToHomepage();
  }

  void navigateToHomepage() {
    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  void initState() {
    super.initState();
    initializeSplash();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
    return MaterialApp(
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
                child: Image.asset("imagens/logojk.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
