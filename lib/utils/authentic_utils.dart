import 'package:firebase_auth/firebase_auth.dart';

class AuthenicUtils {
  bool UserCheck(bool isLogedIn) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLogedIn = false;
      } else {
        isLogedIn = true;
      }
    });
    return isLogedIn;
  }
}
