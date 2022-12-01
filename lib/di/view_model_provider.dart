import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/auth_pages/login/login_view_model.dart';
import 'package:schedule_meeting/ui/auth_pages/register/register_view_model.dart';
import 'package:schedule_meeting/ui/auth_pages/splash/splash_view_model.dart';
import 'package:schedule_meeting/ui/home_list_schedule/home_list_schedule_view_model.dart';
import 'package:schedule_meeting/ui/create_schedule/create_schedule_view_model.dart';
import 'package:schedule_meeting/ui/home/home_view_model.dart';
import 'package:schedule_meeting/ui/schedule_date/schedule_date_view_model.dart';
import 'package:schedule_meeting/ui/setting_pages/general_pages/dart_mode/dart_mode_view_model.dart';
import 'package:schedule_meeting/ui/setting_pages/setting/setting_view_model.dart';

final loginViewModelProvider =
    ChangeNotifierProvider<LoginViewModel>((ref) => LoginViewModel(
          ref.read,
        ));

final registerViewModelProvider =
    ChangeNotifierProvider<RegisterViewModel>((ref) => RegisterViewModel(
          ref.read,
        ));

final splashViewModelProvider =
    ChangeNotifierProvider<SplashViewModel>((ref) => SplashViewModel(ref.read));

final homeViewModelProvider =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(
          ref.read,
        ));
final settingViewModelProvider =
    ChangeNotifierProvider<SettingViewModel>((ref) => SettingViewModel(
          ref.read,
        ));
final homeScheduleViewModelProvider =
    ChangeNotifierProvider<HomeScheduleViewModel>(
        (ref) => HomeScheduleViewModel(
              ref.read,
            ));

final createScheduleViewModelProvider =
    ChangeNotifierProvider<CreateScheduleViewViewModel>(
        (ref) => CreateScheduleViewViewModel(
              ref.read,
            ));

final scheduledateViewModelProvider =
    ChangeNotifierProvider<ScheduleDateViewModel>(
        (ref) => ScheduleDateViewModel(
              ref.read,
            ));

final dartModeViewModelProvider = ChangeNotifierProvider<DartModeViewViewModel>(
    (ref) => DartModeViewViewModel(
          ref.read,
        ));
