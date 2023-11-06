import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking/api/api.dart';
import 'package:turf_booking/home_screen.dart';
import 'package:turf_booking/themes/theme_colors.dart';
import 'package:turf_booking/views/onboard_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (APIs.auth.currentUser != null) {
        log('User: ${FirebaseAuth.instance.currentUser!.uid}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Media query for sizing
    // final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: HashColorCodes.green,
        child: const Center(
          child: Image(
            image: AssetImage('images/logo.png'),
            height: 150,
          ),
        ),
      ),
    );
  }
}
