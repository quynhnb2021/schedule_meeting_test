import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';

abstract class FirebaseHelper {
  Future<void> registerUsingEmailPassword(
    String name,
    String email,
    String password,
    BuildContext context,
    Function? callBackData,
  );

  Future<void> loginWithEmail(String email, String password,
      BuildContext context, Function? callBackData);

  Future<void> createChedules(
      String nameBlog,
      String mail,
      String date,
      String duration,
      String partnerName,
      String timeSlot,
      BuildContext context,
      Function? callBackData);

  Future<void> uploadImage(File file, Function? callBackData);

  Future<void> getSchedule(
      String name, String? type, String? mail, Function? callBackData);

  Future<void> signInGoogle(
      {Function(String email)? authSuccess, Function? authError});
  Future<void> signOut(Function signedOut);
}

class FirebaseManager extends FirebaseHelper {
  FirebaseManager(this._reader);

  final Reader _reader;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Future<void> loginWithEmail(String email, String password,
      BuildContext context, Function? callBackData) async {
    // TODO: implement loginWithEmail
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      callBackData?.call(userCredential);
    } on FirebaseAuthException catch (e) {
      AppFunc.showAlertDialog(context, message: e.message ?? '');
    }
  }

  @override
  Future<void> registerUsingEmailPassword(
    String name,
    String email,
    String password,
    BuildContext context,
    Function? callBackData,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        // name: name,
        password: password,
      );

      userCredential.user;
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        String? idToken = await userCredential.user?.getIdToken(true);
        print("idToken : $idToken");
        callBackData?.call(userCredential);
      }

      // await user!.updateProfile(displayName: name);
      // await user.reload();
      // user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      return AppFunc.showAlertDialog(context, message: e.message ?? '');
    } catch (e) {
      return AppFunc.showAlertDialog(
        context,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> uploadImage(File file, Function? callBackData) async {
    // TODO: implement uploadImage
    final mountainsRef =
        storageRef.child("blogImages").child("${randomAlphaNumeric(9)}.jpg");

    try {
      final task = await mountainsRef.putFile(file).then((p0) async {
        final url = await mountainsRef.getDownloadURL();
        callBackData?.call(url);
      });
    } catch (error) {
      print(error);
      // return null;
    }

    // var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
  }

  @override
  Future<void> createChedules(
      String nameBlog,
      String mail,
      String date,
      String duration,
      String partnerName,
      String timeSlot,
      BuildContext context,
      Function? callBackData) async {
    Map<String, String> blogData = {
      "mail": mail,
      "date": date,
      "duration": duration,
      "partnerName": partnerName,
      "timeSlot": timeSlot,
    };
    await db
        .collection("datas")
        .doc(mail)
        .collection(nameBlog)
        .add(blogData)
        .catchError((e) {
      AppFunc.showAlertDialog(context, message: e.message ?? '');
    });
    callBackData?.call('Ok');
  }

  @override
  Future<void> getSchedule(
      String name, String? type, String? mail, Function? callBackData) async {
    Stream collectionStream = await db
        .collection('datas')
        .doc('bao@gmail.com')
        .collection(name)
        .snapshots();
    callBackData?.call(collectionStream);
    //   if (mail == null) {
    //     if (type == null) {
    //       Stream collectionStream = await db.collection(name).snapshots();
    //       callBackData?.call(collectionStream);
    //     } else {
    //       Stream collectionStream =
    //           await db.collection('datas').doc(mail).collection(name).snapshots();
    //       callBackData?.call(collectionStream);
    //     }
    //   } else {
    //     Stream collectionStream =
    //         await db.collection(name).where('mail', isEqualTo: mail).snapshots();
    //     callBackData?.call(collectionStream);
    //   }
  }

  @override
  Future<void> signInGoogle(
      {Function(String email)? authSuccess, Function? authError}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      if (googleUser != null) {
        print('googleUser.email: ${googleUser.email}');
        authSuccess?.call(googleUser.email);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<void> signOut(Function signedOut) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
      // Obtain the auth details from the request
      if (googleUser != null) {
        print('googleUser.email: ${googleUser.email}');
        signedOut.call(googleUser.email);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
