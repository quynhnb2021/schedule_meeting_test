import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_meeting/ui/base/component/notice_popup/notice_popup.dart';

class AppFunc {
  static void hideKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  responsiveUI(double i) {
    if (i <= 420) {
      return 2.0;
    } else if (i > 420 && i <= 575) {
      return 700.0;
    } else if (i >= 575 && i <= 768) {
      return 150.0;
    } else if (i >= 768 && i <= 992) {
      return 200.0;
    } else if (i >= 992 && i <= 1023) {
      return 250.0;
    } else if (i >= 1023 && i <= 1151) {
      return 300.0;
    } else if (i >= 1151 && i <= 1279) {
      return 380.0;
    } else if (i >= 1279 && i <= 1441) {
      return 450.0;
    } else if (i >= 1441 && i <= 1599) {
      return 620.0;
    } else if (i >= 1599 && i <= 1919) {
      return 700.0;
    } else {
      return 800.0;
    }
  }

  void showBottomDialog(BuildContext context, Widget child) {
    // DateTime dateChanged = DateTime(2016, 10, 26);
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 270,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(top: false, child: child),
            ));
  }

  fullStringTimeFormat(String? stringTime) {
    final date = DateTime.tryParse(stringTime ?? '');
    return date != null ? DateFormat('dd/MM/yyyy').format(date) : '';
  }

  static showAlertDialog(BuildContext context,
      {String? message, String? title}) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title ?? "Notification"),
      content: Text(message ?? ''),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showSuccessDialog(
    BuildContext context,
    String title,
    String content,
    bool isSuccess,
    VoidCallback onDismiss,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => NoticePopup(
              title: title,
              content: content,
              onTouchOK: () {
                Navigator.of(context).pop();
              },
              isSuccessAlert: isSuccess,
            )).whenComplete(() {
      onDismiss();
    });
  }
}
