import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fogetpassword.dart';
import '../init_state.dart';

import '../../theme/my_colors_icons.dart';
import '../signin/signup.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool isSecureText = true;
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Log In",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailCon,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (EmailValidator.validate(value!.trim())) {
                  return null;
                } else {
                  return "Email is not validate.";
                }
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
                labelText: "Email",
                hintText: "Type your email...",
                border: MyColorsIcons.outLinedBorderForTextFromFeild,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: passCon,
                    validator: (value) {
                      if (value!.length >= 8) {
                        return null;
                      } else {
                        return "Password is short";
                      }
                    },
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: isSecureText,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                      labelText: "Password",
                      hintText: "Type your password...",
                      border: MyColorsIcons.outLinedBorderForTextFromFeild,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSecureText = !isSecureText;
                    });
                  },
                  icon: isSecureText
                      ? const Icon(
                          Icons.visibility_off,
                          color: MyColorsIcons.gradient2,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: MyColorsIcons.gradient2,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPassword(),
                  ),
                );
              },
              child: const Text(
                "Forget Password?",
                style: TextStyle(
                  color: MyColorsIcons.gradient2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: MyColorsIcons.gradient2,
                minimumSize: const Size(300, 60)),
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: MyColorsIcons.gradient2,
                  ),
                ),
              );
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailCon.text.trim(),
                password: passCon.text,
              );
              // ignore: use_build_context_synchronously
              if (Navigator.canPop(context)) Navigator.pop(context);
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const InItState(),
                ),
              );
            },
            child: const Text(
              "LogIn",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Haven't account?  "),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                child: const Text(
                  "SignUp",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: MyColorsIcons.gradient2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
