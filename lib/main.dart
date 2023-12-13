import 'package:flutter/material.dart';
import 'package:muflix/screens/api_test.dart';
import 'package:muflix/screens/home_frame.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/imageUploader.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/signup_screen.dart';
import 'firebase_options.dart';
import 'screens/test_screen.dart';
import 'screens/welcome_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(const MuFlix());
}

class MuFlix extends StatefulWidget {
  const MuFlix({super.key});

  @override
  State<MuFlix> createState() => _MuflixState();
}

class _MuflixState extends State<MuFlix> {
  @override
  void initState() {
    super.initState();
  }

  late TabController controller;

  @override
  Widget build(BuildContext context) {
    // Logger().i(
    //     'FirebaseAuth.instance.currentUser: ${FirebaseAuth.instance.currentUser}');
    // final isLogedIn = FirebaseAuth.instance.currentUser != null;
    // Logger().i('isLogedIn: $isLogedIn');
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        hintColor: Colors.black,

        //마우스 호버시 효과 제거
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,

        //버튼 스타일
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(120, 48.0),
            ), // 버튼의 최소 크기 설정
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFD9232E),
            ), // ElevatedButton의 배경색
            elevation: MaterialStateProperty.all(0.0), // 그림자
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(120.0, 48.0),
            ), // 버튼의 최소 크기 설정
            foregroundColor:
                MaterialStateProperty.all(Colors.green), // TextButton의 글자색
          ),
        ),
      ),

      initialRoute: '/', // 초기 경로 설정
      routes: {
        '/': (context) => const HomeFrame(),
        '/apitest': (context) => ApiTest(),
        '/test': (context) => const TestScreen(),
        '/imageUploader': (context) => const ImageUploader(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
