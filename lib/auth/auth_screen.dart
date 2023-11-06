import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turf_booking/api/api.dart';
import 'package:turf_booking/common/dialogs.dart';
import 'package:turf_booking/home_screen.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class AuthChekaScreen extends StatefulWidget {
  const AuthChekaScreen({super.key});

  @override
  State<AuthChekaScreen> createState() => _AuthChekaScreenState();
}

class _AuthChekaScreenState extends State<AuthChekaScreen> {
  HandleGoogleBtnClick() {
    //showing loder

    Dialogs.showLoader(context);
    signInWithGoogle().then((user) async {
      //hiding Loder
      Navigator.pop(context);
      if (user != null) {
        //printing user detail
        log('User : ${user.user}');
        log('User Additional Info : ${user.additionalUserInfo}');

        if (await (APIs.userExist())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('signInWithGoogle: $e');
      Dialogs.showSnackbar(
          context, "Something Went Wrong Check Your Internet Connection..!");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(children: [
          Center(
              child: Image(
            image: const AssetImage('images/login_banner.png'),
            height: mq.height * .30,
          )),
          const Text(
            "Welcome To Turf",
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w900,
                fontFamily: 'Urbanist'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "FieldFinder is your go-to platform for discovering the best turf fields for your game. Whether it's soccer, cricket, or any other sport, we've got you covered.",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Sarala'),
          ),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 90,
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {
              HandleGoogleBtnClick();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HashColorCodes.white,
              elevation: mq.height * 0.01,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the text horizontally
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/google-logo.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Login with Google',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Sarala',
                    color: HashColorCodes.grey,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
