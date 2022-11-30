import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';

const isFistLogin = 1;

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(Reader reader) : super(reader);

  final TextEditingController mailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  tapRegister(BuildContext context) async {
    setBusy(true);
    await appApiHelper.registerUsingEmailPassword(
        nameController.text.trim(),
        mailController.text.trim(),
        passwordController.text.trim(),
        context, (data) {
      print(data);
      setBusy(false);
      Fluttertoast.showToast(msg: 'Register member successfully');
      Navigator.of(context).pop();
    });
    setBusy(false);
  }
}
