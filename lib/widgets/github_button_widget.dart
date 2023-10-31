import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GitHubBotton extends StatelessWidget {
  const GitHubBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          GithubAuthProvider githubProvider = GithubAuthProvider();
          await FirebaseAuth.instance.signInWithRedirect(githubProvider);
          Navigator.pushNamed(context, '/');
        } catch (e) {
          Logger().i(e);
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/256/25/25231.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Github 계정으로 로그인',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
