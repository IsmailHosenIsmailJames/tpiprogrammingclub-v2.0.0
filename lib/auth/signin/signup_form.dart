import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../init_state.dart';
import '../sent_validation_email.dart';
import '../../core/iamge_picker.dart';
import 'sent_user_data_server.dart';
import '../../core/show_toast.dart';

import '../../theme/my_colors_icons.dart';
import '../login/login.dart';
import 'create_user.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isSecureText = true;
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  String? url = "";
  File? picForMobile;
  Uint8List? picForWeb;
  Widget profileAvatar = const Icon(Icons.person, size: 80);

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
            "Sign Up",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: MyColorsIcons.gradient2,
                child: profileAvatar,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: name,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.length > 1) {
                  return null;
                } else {
                  return "Name is not validate.";
                }
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
                labelText: "Name",
                hintText: "Type your name...",
                border: MyColorsIcons.outLinedBorderForTextFromFeild,
              ),
            ),
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: MyColorsIcons.gradient2,
                      ),
                    ),
                  );

                  if (!kIsWeb) {
                    await pickPhotoMobile(emailCon.text.trim()).then((value) {
                      setState(() {
                        url = value.url;
                        picForMobile = value.imageFile;
                      });
                    });
                  } else {
                    await pickPhotoWeb(emailCon.text.trim()).then((value) {
                      setState(() {
                        url = value.url;
                        picForWeb = value.imageFile;
                      });
                    });
                  }
                  // ignore: use_build_context_synchronously
                  if (Navigator.canPop(context)) Navigator.pop(context);
                  if (url == null) {
                    showToast("Please select a profile.");
                    return;
                  } else {
                    showToast("Image Upload Successful!");
                    setState(() {
                      if (picForMobile != null) {
                        profileAvatar = Image.file(
                          picForMobile!,
                          fit: BoxFit.cover,
                        );
                      } else if (picForWeb != null) {
                        profileAvatar = Image.memory(
                          picForWeb!,
                          fit: BoxFit.cover,
                        );
                      }
                    });
                  }
                }
              },
              child: const Text("Browse Photo ..."),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: MyColorsIcons.gradient2,
                minimumSize: const Size(300, 60)),
            onPressed: () async {
              if (url == null) {
                showToast("Please select a profile photo.");
                return;
              }

              showModalBottomSheet(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: MyColorsIcons.gradient2,
                  ),
                ),
              );
              await createUser(emailCon.text.trim(), passCon.text);
              await sentUserDataServer(
                  emailCon.text.trim(), name.text.trim(), url!);
              await sentValidationEmail();
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
              "SignIn",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Already haven account?  "),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
                child: const Text(
                  "LogIn",
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
