import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';

const isFistLogin = 1;

class LoginViewModel extends BaseViewModel {
  LoginViewModel(Reader reader) : super(reader);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var enableLogin = false;

  updateUserNamePass(String mail, String pass) {
    usernameController.text = mail;
    // passwordController.text = pass;
  }

  bool checkInputsNotExistEmpty() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void onChangeInut() {
    if (!checkInputsNotExistEmpty()) {
      enableLogin = false;
      notifyListeners();
    }
    if (checkInputsNotExistEmpty()) {
      enableLogin = true;
      notifyListeners();
    }
  }

  tapLogin(BuildContext context, Function callBack) async {
    setBusy(true);
    await appApiHelper.loginWithEmail(
        usernameController.text.trim(), passwordController.text.trim(), context,
        (data) async {
      print(data.user.email);
      await sharedPref.saveMail(data.user.email);
      await sharedPref.saveNameUser(data.user.displayName);
      setBusy(false);
      Fluttertoast.showToast(msg: 'Login successfully');
      usernameController.text = '';
      passwordController.text = '';
      callBack.call();
    });

    setBusy(false);
  }

  tapGoogleSignIn(Function callBack) async {
    setBusy(true);
    await appApiHelper.signInGoogle(authSuccess: (data) {
      print(data);
      setBusy(false);
      Fluttertoast.showToast(msg: 'Login successfully');
      callBack.call(true);
    });
    setBusy(false);
  }
}
