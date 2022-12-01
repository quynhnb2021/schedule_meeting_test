import 'package:auto_route/auto_route.dart';
import 'package:schedule_meeting/ui/auth_pages/login/login_view.dart';
import 'package:schedule_meeting/ui/auth_pages/register/register_view.dart';
import 'package:schedule_meeting/ui/auth_pages/splash/splash_view.dart';
import 'package:schedule_meeting/ui/create_schedule/create_schedule_view.dart';
import 'package:schedule_meeting/ui/home/home_view.dart';
import 'package:schedule_meeting/ui/setting_pages/general_pages/dart_mode/dart_mode_view.dart';
import 'package:schedule_meeting/ui/setting_pages/setting/setting_view.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashView, initial: true),
    AutoRoute(page: LoginView),
    AutoRoute(page: RegisterView),
    AutoRoute(page: SettingView),
    AutoRoute(page: DartModeView),
    AutoRoute(page: CreateScheduleView),
    CustomRoute(
      page: HomeView,
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
  ],
)
class $AppRouter {}
