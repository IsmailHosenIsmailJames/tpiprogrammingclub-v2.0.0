import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../theme/change_button_theme.dart';
import 'login_form_feild.dart';
import '../welcome.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                  child: const LogInForm(),
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
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(80, 139, 139, 139),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const LogInForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
