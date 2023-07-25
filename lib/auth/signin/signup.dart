import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../theme/change_button_theme.dart';
import '../welcome.dart';
import 'signup_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        // desktop layouts
        desktop: (p0) => ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                  label: const Text(
                    "About",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.feedback_outlined),
                  label: const Text(
                    "Feed Back",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const ChangeThemeButtonWidget(value: 1),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(80, 139, 139, 139),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const WelcomeLogIn(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(80, 139, 139, 139),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const SignUpForm(),
                ),
              ],
            ),
          ],
        ),
        mobile: (p0) => ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.feedback_outlined),
                ),
                const SizedBox(
                  width: 20,
                ),
                const ChangeThemeButtonWidget(value: 1),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(80, 139, 139, 139),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const WelcomeLogIn()),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(80, 139, 139, 139),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const SignUpForm(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
