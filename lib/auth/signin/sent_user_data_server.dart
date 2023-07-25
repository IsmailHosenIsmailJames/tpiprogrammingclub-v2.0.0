import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> sentUserDataServer(String email, String name, String url) async {
  try {
    final temRef = FirebaseFirestore.instance.collection('user').doc('allUser');
    final allUser = await temRef.get();
    List allUserList = allUser['email'];
    allUserList.add(email);
    await temRef.set({'email': allUserList});

    final json = {
      "profile": url,
      "name": name,
      "like": 0,
      'post': [""],
      'pendingPost': [""],
      "chatID": allUserList.length
    };
    final firebaseref =
        FirebaseFirestore.instance.collection('user').doc(email);
    await firebaseref.set(json);
    return true;
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
      msg: e.message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      timeInSecForIosWeb: 3,
    );
    return false;
  }
}
