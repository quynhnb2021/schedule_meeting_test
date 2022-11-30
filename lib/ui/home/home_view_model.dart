import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/app_config.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(Reader reader) : super(reader);
  int bottomSelectedItem = 0;

  updateIndex(int i) {
    bottomSelectedItem = i;
    notifyListeners();
  }
}
