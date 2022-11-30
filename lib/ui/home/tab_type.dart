import 'package:flutter/material.dart';

enum TabType { blog, createblog, setting }

Widget mapTabTypeToIconUri(TabType type) {
  switch (type) {
    case TabType.blog:
      return const Icon(Icons.home);
    case TabType.createblog:
      return const Icon(Icons.date_range);

    case TabType.setting:
      return const Icon(Icons.settings);
  }
}

String mapTabTypeToLabel(TabType type) {
  switch (type) {
    case TabType.createblog:
      return 'Schedule';
    case TabType.blog:
      return 'Home';
    case TabType.setting:
      return 'Setting';
  }
}
