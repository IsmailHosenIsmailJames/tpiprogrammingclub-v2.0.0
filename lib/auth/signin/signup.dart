import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tpiprogrammingclub/auth/signin/sent_user_data_server.dart';

import '../../core/image_picker.dart';
import '../../core/show_toast.dart';
import '../../theme/change_button_theme.dart';
import '../../theme/my_colors_icons.dart';
import '../init_state.dart';
import '../login/login.dart';
import '../sent_validation_email.dart';
import 'create_user.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  bool isSecureText = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final conPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  String? url = "";
  File? picForMobile;
  Uint8List? picForWeb;
  Widget profileAvatar = const Icon(Icons.person, size: 80);

  Widget signInButtonAndProgressWidget = const Text("SignIn");

  void signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        signInButtonAndProgressWidget = const CircularProgressIndicator(
          color: Colors.white,
        );
      });
      try {
        await createUser(emailController.text.trim(), passController.text);
        await sentUserDataServer(
          emailController.text.trim(),
          nameController.text.trim(),
          url == null ? "" : url!,
        );
        await sentValidationEmail();

        setState(() {
          signInButtonAndProgressWidget = const Text("SignIn");
        });
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InItState(),
            ));
      } catch (e) {
        showToast(e.toString());
        setState(() {
          signInButtonAndProgressWidget = const Text("SignIn");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(50, 150, 150, 150),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: MyColorsIcons.gradient2,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      height: 70,
                      width: 70,
                      child: const ChangeThemeButtonWidget(value: 1),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: 30,
                  ),
                  child: Form(
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
                            color: MyColorsIcons.gradient2,
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
                            controller: nameController,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length > 1) {
                                return null;
                              } else {
                                return "Name is not validate.";
                              }
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                              labelText: "Name",
                              hintText: "Type your nameController...",
                              border:
                                  MyColorsIcons.outLinedBorderForTextFromFeild,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            focusNode: emailFocus,
                            controller: emailController,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (EmailValidator.validate(value!.trim())) {
                                return null;
                              } else {
                                return "Email is not validate.";
                              }
                            },
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                              labelText: "Email",
                              hintText: "Type your email...",
                              border:
                                  MyColorsIcons.outLinedBorderForTextFromFeild,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  focusNode: passwordFocus,
                                  controller: passController,
                                  validator: (value) {
                                    if (value!.length >= 8) {
                                      return null;
                                    } else {
                                      return "Password is short";
                                    }
                                  },
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(confirmPasswordFocus);
                                  },
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: isSecureText,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                    labelText: "Password",
                                    hintText: "Type your password...",
                                    border: MyColorsIcons
                                        .outLinedBorderForTextFromFeild,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  focusNode: confirmPasswordFocus,
                                  controller: conPassController,
                                  validator: (value) {
                                    if (value! == passController.text) {
                                      return null;
                                    } else {
                                      return "Password didn't massed";
                                    }
                                  },
                                  onEditingComplete: () {
                                    signUp();
                                  },
                                  autocorrect: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: isSecureText,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                    labelText: "Confirm Password",
                                    hintText: "Type your password again...",
                                    border: MyColorsIcons
                                        .outLinedBorderForTextFromFeild,
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
                                  await pickPhotoMobile(
                                          "user/${emailController.text.trim()}")
                                      .then((value) {
                                    setState(() {
                                      url = value.url;
                                      picForMobile = value.imageFile;
                                    });
                                  });
                                } else {
                                  await pickPhotoWeb(
                                          "user/${emailController.text.trim()}")
                                      .then((value) {
                                    setState(() {
                                      url = value.url;
                                      picForWeb = value.imageFile;
                                    });
                                  });
                                }
                                // ignore: use_build_context_synchronously
                                if (Navigator.canPop(context)) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
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
                            child: const Text(
                              "Browse Photo ...",
                              style: TextStyle(color: MyColorsIcons.gradient2),
                            ),
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
                            signUp();
                          },
                          child: signInButtonAndProgressWidget,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
