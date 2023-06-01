import 'package:flutter/material.dart';

import '../util/auth.dart';
import '../util/google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height - 300) / 2,
            ),
            SizedBox(
              height: 300,
              child: Image.asset('assets/images/splash.png'),
            ),
            const SizedBox(
              height: 80,
            ),
            FutureBuilder(
              future: Authentication.initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return const GoogleSignInButton();
                }
                return const CircularProgressIndicator(
                  color: Color(0xffff0c4c8a),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
