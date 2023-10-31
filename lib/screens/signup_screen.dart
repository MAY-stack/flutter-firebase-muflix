import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(top: 7),
          child: Image.asset(
            'images/MUFLIX.png',
            fit: BoxFit.contain,
            height: 32,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // 모서리를 더 둥글게 설정
                ),
                child: const SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {
  bool isLoading = false;
  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState> not a GlobalKey<SignUpFormState>.
  final _signUpFormKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  String signupError = '';

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _signupFormKey created above.
    return Column(
      children: [
        const SizedBox(),
        Form(
          key: _signUpFormKey,
          child: Center(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이름 입력 폼
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '이름',
                        ),
                        validator: (inputName) {
                          if (inputName == null || inputName.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            userName = inputName;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // 이메일 입력 폼
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '이메일 주소',
                          hintStyle: TextStyle(),
                        ),
                        validator: (inputEmail) {
                          if (inputEmail == null || inputEmail.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            userEmail = inputEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '비밀번호',
                        ),
                        validator: (inputPassword) {
                          if (inputPassword == null || inputPassword.isEmpty) {
                            return 'Please enter some text';
                          } else {
                            userPassword = inputPassword;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  // 회원가입 버튼
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 320,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_signUpFormKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            // ScaffoldMessenger.of(context).showSnackBar(
                            try {
                              isLoading = true;
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword);
                              await FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(userName);
                              Navigator.pushNamed(context, '/');
                            } catch (e) {
                              setState(() {
                                signupError = e.toString();
                              });
                              Logger().i(e);
                            } finally {}
                          }
                        },
                        child: const Text(
                          '회원가입',
                        ),
                      ),
                    ),
                  ),

                  Text(signupError),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
