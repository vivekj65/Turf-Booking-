import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turf_booking/about_screen.dart';
import 'package:turf_booking/api/api.dart';
import 'package:turf_booking/auth/auth_screen.dart';
import 'package:turf_booking/model/user_model.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: APIs.getSelfInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            log("User Data: $userData");
            final user = TurfUser(
              id: APIs.user.uid,
              name: userData['name'] ?? '',
              email: userData['email'] ?? '',
            );

            return Column(
              children: [
                Container(
                  width: screenWidth,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: HashColorCodes.screenGrey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            color: HashColorCodes.white,
                            size: 110,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.email,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AboutScreen()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: mq.height * .07,
                        color: HashColorCodes.screenGrey,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text("About Us"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 2,
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: HashColorCodes.green,
                  ),
                  onPressed: () async {
                    try {
                      await APIs.auth.signOut();
                      await GoogleSignIn().signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => AuthChekaScreen()));
                    } catch (e) {
                      log("Sign out error: $e");
                    }
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(color: HashColorCodes.white),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error fetching user data: ${snapshot.error}");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
