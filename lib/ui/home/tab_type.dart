import 'package:flutter/material.dart';

enum TabType { createSchedule, setting }

Widget mapTabTypeToIconUri(TabType type) {
  switch (type) {
    // case TabType.blog:
    //   return const Icon(Icons.home);
    case TabType.createSchedule:
      return const Icon(Icons.date_range);

    case TabType.setting:
      return const Icon(Icons.settings);
  }
}

String mapTabTypeToLabel(TabType type) {
  switch (type) {
    case TabType.createSchedule:
      return 'Schedule';
    // case TabType.blog:
    //   return 'Home';
    case TabType.setting:
      return 'Setting';
  }
}
