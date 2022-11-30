import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';

const isFistLogin = 1;

class LoginViewModel extends BaseViewModel {
  LoginViewModel(Reader reader) : super(reader);
  tapLogin(
      String mail, String pw, BuildContext context, Function callBack) async {
    setBusy(true);
    await appApiHelper.loginWithEmail(mail, pw, context, (data) async {
      print(data.user.email);
      await sharedPref.saveMail(data.user.email);
      setBusy(false);
      Fluttertoast.showToast(msg: 'Login successfully');
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
