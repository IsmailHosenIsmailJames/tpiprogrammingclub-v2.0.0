import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tpiprogrammingclub/theme/my_colors_icons.dart';

class WelcomeLogIn extends StatelessWidget {
  const WelcomeLogIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "TPI Programming Club",
              style: TextStyle(
                color: MyColorsIcons.gradient2,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 24,
                color: MyColorsIcons.gradient2,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Let\'s learn togethers...',
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'Let\'s help each others...',
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'TPI Programming Club is for Learners...',
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'TPI Programming Club is for Begainners...',
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'TPI Programming Club is for Programmers...',
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Learn to Code",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Let\'s Learn',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  const SizedBox(width: 20.0, height: 100.0),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.green,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText('C'),
                        RotateAnimatedText('C++'),
                        RotateAnimatedText('Java'),
                        RotateAnimatedText('JavaScript'),
                        RotateAnimatedText('Python'),
                        RotateAnimatedText('HTML'),
                        RotateAnimatedText('CSS'),
                        RotateAnimatedText('Flutter'),
                        RotateAnimatedText(''),
                      ],
                    ),
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
