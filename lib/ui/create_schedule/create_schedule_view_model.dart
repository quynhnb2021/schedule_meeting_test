import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';

class CreateScheduleViewViewModel extends BaseViewModel {
  CreateScheduleViewViewModel(Reader reader) : super(reader);

  final ImagePicker _picker = ImagePicker();

  File? selectedImage;
  String dateCurrent = "";
  String duration = "10";
  String partnerName = "Quynh";
  String timeSlot = "8h - 12h";
  final partners = ["Quynh", "Long", "Giang", "Lan", "Ngoc", "Anh", "Kaka"];
  final now = DateTime.now();
  BuildContext? context;
  final durations = ["15", "30", "60", "120", "180", "240", "300"];
  final timeSlots = ["4h - 8h", "8h - 12h", "12h - 16h", "16h - 20h"];

  getContext(BuildContext c) {
    context = c;
    notifyListeners();
  }

  getDate(BuildContext c) {
    dateCurrent = "${now.year} - ${now.month} - ${now.day}";
    getContext(c);
    notifyListeners();
  }

  updateDuration(String s) {
    duration = s;
    notifyListeners();
  }

  updatePartner(String s) {
    partnerName = s;
    notifyListeners();
  }

  updateTimeslot(String s) {
    timeSlot = s;
    notifyListeners();
  }

  selectDate() async {
    var pickedDate = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      dateCurrent = DateFormat('yyyy-MM-dd').format(pickedDate);
      notifyListeners();
    }
  }

  createScheduleNew(BuildContext context) async {
    setBusy(true);
    final mail = await sharedPref.getMail();
    await appApiHelper.createChedules('schedules', mail, dateCurrent, duration,
        partnerName, timeSlot, context, (data) {
      print(data);
      setBusy(false);
      Fluttertoast.showToast(msg: 'Create Blog successfully');
      String dateCurrent = "";
      String duration = "10";
      String partnerName = "Quynh";
      String timeSlot = "8h - 12h";
      Navigator.pop(context);
    });
    setBusy(false);
  }

  // Future<bool> getImage() async {
  //   // setBusy(true);
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // setBusy(false);
  //   if (image != null) {
  //     selectedImage = File(image.path);
  //     await appApiHelper.uploadImage(selectedImage!, (data) {
  //       print(data);
  //       urlImg = data;
  //     });
  //     notifyListeners();

  //     return true;
  //   }
  //   return false;
  // }

}
