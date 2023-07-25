import 'package:firebase_auth/firebase_auth.dart';
import 'package:tpiprogrammingclub/core/show_toast.dart';

Future<bool> createUser(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    showToast(e.message!);
    return false;
  }
}
