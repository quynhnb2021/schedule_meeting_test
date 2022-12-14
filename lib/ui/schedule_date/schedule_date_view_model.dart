import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_planner/time_planner.dart';

class ScheduleDateViewModel extends BaseViewModel {
  ScheduleDateViewModel(Reader reader) : super(reader);
  List<TimePlannerTask> tasks = [];

  final authorTF = TextEditingController();
  final titleTF = TextEditingController();
  final descriptionTF = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String type = 'Sports';
  String urlImg = '';
  File? selectedImage;

  addTask(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.lime[600]
    ];

    tasks.add(
      TimePlannerTask(
        color: colors[Random().nextInt(colors.length)],
        dateTime: TimePlannerDateTime(
            day: Random().nextInt(14),
            hour: Random().nextInt(18) + 6,
            minutes: Random().nextInt(60)),
        minutesDuration: Random().nextInt(90) + 30,
        daysDuration: Random().nextInt(4) + 1,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('You click on time planner object')));
        },
        child: Text(
          'this is a demo',
          style: TextStyle(color: Colors.grey[350], fontSize: 12),
        ),
      ),
    );
    notifyListeners();
  }

  Future<bool> getImage() async {
    // setBusy(true);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // setBusy(false);
    if (image != null) {
      selectedImage = File(image.path);
      await appApiHelper.uploadImage(selectedImage!, (data) {
        print(data);
        urlImg = data;
      });
      notifyListeners();

      return true;
    }
    return false;
  }
}
