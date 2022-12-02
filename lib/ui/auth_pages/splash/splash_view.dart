import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/data/model/local/app_preferences_helper.dart';
import 'package:schedule_meeting/route/app_route.gr.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/themes/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final router = useRouter();
    // final SplashViewModel viewModel = ref.watch(splashViewModelProvider);

    Future<void> checkAuth() async {
      final prefs = await SharedPreferences.getInstance();
      final mail = prefs.getString(prefMail) ?? '';
      if (mail.isNotEmpty) {
        if (kIsWeb) {
          router.push(const LoginRoute());
        } else {
          router.push(const HomeRoute());
        }
      } else {
        router.push(const LoginRoute());
      }
    }

    useEffectAsync(
        () => Future.delayed(const Duration(milliseconds: 2000), () async {
              await checkAuth();
            }));

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
            horizontal: AppFunc().responsiveUI(width), vertical: 15),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              // Image.asset(
              //   "assets/icons/login/loading_11.png",
              //   width: 178,
              //   height: 188,
              // ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Schedule a Meeting App",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Provide useful products for life.",
                style: TextStyles.regularText14.w400.colorPrimaryGray,
              ),
              const Spacer(),
              // Text(
              //   "Copyright © 2022-2023 Schedule a Meeting App\n All Rights Reserved.",
              //   textAlign: TextAlign.center,
              //   style: TextStyles.regularText14.w400.colorPrimaryGray,
              // ),
            ]),
      ),
    );
  }
}
