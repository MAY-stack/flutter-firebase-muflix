import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/github_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = ''; // 이메일을 저장할 변수
  String password = ''; // 비밀번호를 저장할 변수
  bool isRunning = true;

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
            const SizedBox(height: 50),
            Container(
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // 모서리를 더 둥글게 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 이메일 입력 폼
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        onChanged: (value) {
                          // 이메일이 변경될 때마다 실행되는 콜백
                          email = value; // 이메일 변수에 저장
                        },
                      ),
                    ),
                  ),

                  // 비밀번호 입력 폼
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        // obscureText: true, // 입력 내용을 숨깁니다.
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        // 입력되는 비밀번호가 변경될 때마다
                        onChanged: (value) {
                          password = value; // 비밀번호 변수에 저장
                        },
                      ),
                    ),
                  ),

                  // 로그인 버튼
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 320,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isRunning = false;
                          });
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            setState(() {
                              isRunning = true;
                            });
                            Logger().i('로그인 성공');
                            Navigator.pushNamed(context, '/');
                            // 로그인 성공
                          } catch (e) {
                            // 로그인 실패 시 에러 처리
                            Logger().i(e.toString());
                          }
                        },
                        child: isRunning
                            ? const Text(
                                '로그인',
                              )
                            : const Icon(Icons.refresh),
                      ),
                    ),
                  ),

                  //회원가입 & 깃허브 로그인 버튼
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 회원가입 버튼
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('회원이 아니시라면?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration:
                                        TextDecoration.underline, // 밑줄 추가
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: const Center(
                          child: Text('또는'),
                        ),
                      ),

                      // 깃허브 로그인 버튼
                      const GitHubBotton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
