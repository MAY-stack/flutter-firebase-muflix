import 'package:flutter/material.dart';

import '../widgets/welcome_carousel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            margin: const EdgeInsets.only(top: 7),
            child: Image.asset(
              'assets/images/muflix_logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ),
          centerTitle: true),
      body: Center(
        child: Column(
          children: [
            const WelcomeCarousel(),
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text('로그인'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
