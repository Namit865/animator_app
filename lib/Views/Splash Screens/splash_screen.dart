import 'dart:async';
import 'package:animator_app/Views/Home%20Screens/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationShape;
  late Animation<double> animationHeight;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80,
          width: 80,
          color: Colors.black,
        ),
      ),
    );
  }
}
