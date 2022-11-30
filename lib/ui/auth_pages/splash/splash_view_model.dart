import 'package:schedule_meeting/ui/base/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel(super.reader);

  checkLogin() async {
    final data = await sharedPref.getMail();
    if (data.isNotEmpty) {}
  }
}
