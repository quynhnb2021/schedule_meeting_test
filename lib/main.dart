import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/data/model/local/app_preferences_helper.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/route/app_route.gr.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/setting_pages/setting/setting_view_model.dart';
import 'package:schedule_meeting/ui/themes/theme_dark.dart';
import 'package:schedule_meeting/ui/themes/theme_light.dart';
import 'package:shared_preferences/shared_preferences.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // await dotenv.load(fileName: kReleaseMode ? ".env-release" : ".env-dev");
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends HookConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingViewModel viewModel = ref.watch(settingViewModelProvider);

    Future<void> getTheme() async {
      final prefs = await SharedPreferences.getInstance();
      final isAuto = prefs.getBool(prefThemeDark) ?? false;
      viewModel.onChangedDarkMode(isAuto);
    }

    useEffectAsync(() async {
      getTheme();
    });

    final appRouter = useMemoized(() => AppRouter());

    return MaterialApp.router(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: AppThemeLight().getTheme(),
      darkTheme: AppThemeDark().getTheme(),
      themeMode: viewModel.isDarkModeActive ? ThemeMode.dark : ThemeMode.light,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
