import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import 'login/login.dart';

class InItState extends StatelessWidget {
  const InItState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) =>
          snapshot.hasData ? const HomePage() : const LogIn(),
    );
  }
}
