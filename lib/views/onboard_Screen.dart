
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:turf_booking/auth/auth_screen.dart';
import 'package:turf_booking/themes/theme_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/onbord-image-1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: const Text(
          "Find Your Ideal Turf Field",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),
        bodyWidget: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Search for Nearby Sports Fields and Facilities",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Explore a world of high-quality products, personalized recommendations, and doorstep delivery. Experience hassle-free shopping and exclusive deals as you embark on a new way to shop with us!',
              style: TextStyle(
                fontSize: 16.0,
                color: HashColorCodes.grey,
              ),
            ),
          ],
        ),
      ),
      PageViewModel(
        image: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/onbord-image-2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: const Text(
          "Book Your Preferred Time Slot",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),
        bodyWidget: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Reserve the Perfect Time for Your Game",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Add items to your cart with a tap. Customize your orders, set preferences, and easily schedule deliveries or pickups.',
              style: TextStyle(
                fontSize: 16.0,
                color: HashColorCodes.grey,
              ),
            ),
          ],
        ),
      ),
      PageViewModel(
        image: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/onbord-image-3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: const Text(
          "Confirm Your Reservation",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),
        bodyWidget: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ready to Play? Confirm Your Booking in Seconds",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Join thousands of satisfied customers who trust us for their grocery needs. Let us start shopping!',
              style: TextStyle(
                fontSize: 16.0,
                color: HashColorCodes.grey,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context).size;
    return IntroductionScreen(
      done: const Text("Done"),
      onDone: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const AuthChekaScreen()));
      },
      pages: getPages(),
      showNextButton: true,
      next: const Text("Next"),
    );
  }
}
