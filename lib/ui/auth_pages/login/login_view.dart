import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/route/app_route.gr.dart';
import 'package:schedule_meeting/ui/auth_pages/auth_view/text_input_password.dart';
import 'package:schedule_meeting/ui/auth_pages/login/login_view_model.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';
import 'package:schedule_meeting/ui/base/component/button/button.dart';
import 'package:schedule_meeting/ui/base/component/loading/container_with_loading.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/themes/text_styles.dart';

class LoginView extends BaseView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final router = useRouter();
    // int width = 0;
    // final trans = useLocalizations();

    final LoginViewModel loginViewModel = ref.watch(loginViewModelProvider);

    // useEffectAsync(() async {
    //   onChangeInut();
    // });

    // useEffect(() {
    //   usernameController.text = 'bao@gmail.com';
    //   passwordController.text = '12341234';
    //   onChangeInut();
    // });

    Future<void> onLoggin() async {
      await loginViewModel.tapLogin(context, () {
        router.push(
          const HomeRoute(),
        );
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppFunc().responsiveUI(width)),
        child: ContainerWithLoading(
            provider: loginViewModelProvider,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SizedBox(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "SingIn ",
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        TextInputPassword(
                          controller: loginViewModel.usernameController,
                          hintText: "Enter mail",
                          type: TextInputType.emailAddress,
                          securityType: InputSecurityType.email,
                          onChanged: (String value) {
                            loginViewModel.onChangeInut();
                          },
                        ),
                        const SizedBox(height: 16),
                        TextInputPassword(
                          hintText: "Enter password",
                          type: TextInputType.emailAddress,
                          controller: loginViewModel.passwordController,
                          securityType: InputSecurityType.password,
                          onChanged: (String value) {
                            loginViewModel.onChangeInut();
                          },
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 28),
                        Button(
                          title: "Login",
                          onPress: onLoggin,
                          enable: loginViewModel.enableLogin,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            router.navigate(
                              const RegisterRoute(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Register New?",
                                style: TextStyles.regularText14.colorPrimaryGray
                                    .copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      )),
    );
  }
}
