import 'package:flutter/material.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(
              color: HashColorCodes.white,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: HashColorCodes.green,
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   "About Us",
            //   style: TextStyle(
            //       color: HashColorCodes.black,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 18),
            // ),
            Text(
              "Welcome to TCk turf..!",
              style: TextStyle(
                  color: HashColorCodes.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "TCK Turf in Kolhapur is your trusted source for high-quality turf and landscaping solutions. With over a decade of local expertise, we provide premium turf varieties, professional installation services, and a range of landscaping supplies. Our team offers expert advice, ensuring your outdoor space thrives in the Kolhapur climate. We prioritize customer satisfaction, offering competitive prices without compromising on quality. Choose TCK Turf for a lush, green, and sustainable landscape that transforms your outdoor space into a beautiful haven. Your dream garden is just a call away!",
              style: TextStyle(
                  color: HashColorCodes.black,
                  // fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
