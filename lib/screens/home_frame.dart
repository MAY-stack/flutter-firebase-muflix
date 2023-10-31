import 'package:flutter/material.dart';
import 'package:muflix/screens/profile_screen.dart';
import 'package:muflix/widgets/bottom_bar.dart';

import 'home_screen.dart';
import 'like_screen.dart';
import 'search_screen.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({super.key});

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     Logger().i('logout');
    //     Navigator.pushNamed(context, '/welcome');
    //   }
    // });
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            SearchScreen(),
            LikeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
