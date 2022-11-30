import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/route/app_route.gr.dart';
import 'package:schedule_meeting/ui/auth_pages/auth_view/text_input_password.dart';
import 'package:schedule_meeting/ui/auth_pages/login/login_view_model.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:schedule_meeting/ui/base/component/button/button.dart';
import 'package:schedule_meeting/ui/base/component/loading/container_with_loading.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/themes/text_styles.dart';

class LoginView extends BaseView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();
    // final trans = useLocalizations();
    final TextEditingController usernameController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final enableLogin = useState(false);
    final LoginViewModel loginViewModel = ref.watch(loginViewModelProvider);

    bool checkInputsNotExistEmpty() {
      return usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    }

    void onChangeInut() {
      if (enableLogin.value && !checkInputsNotExistEmpty()) {
        enableLogin.value = false;
      }
      if (!enableLogin.value && checkInputsNotExistEmpty()) {
        enableLogin.value = true;
      }
    }

    // useEffect(() {
    //   usernameController.text = 'bao@gmail.com';
    //   passwordController.text = '12341234';
    //   onChangeInut();
    // });

    Future<void> onLoggin() async {
      await loginViewModel.tapLogin(
          usernameController.text.trim(), passwordController.text, context, () {
        router.push(
          const HomeRoute(),
        );
      });
    }

    Future<void> onGoogleSignIn() async {
      await loginViewModel.tapGoogleSignIn((data) {
        router.push(
          const HomeRoute(),
        );
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: ContainerWithLoading<LoginViewModel>(
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
                              "SingIn Schedule Meeting",
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          TextInputPassword(
                            controller: usernameController,
                            hintText: "Enter mail",
                            type: TextInputType.emailAddress,
                            securityType: InputSecurityType.email,
                            onChanged: (String value) {
                              onChangeInut();
                            },
                          ),
                          const SizedBox(height: 16),
                          TextInputPassword(
                            hintText: "Enter password",
                            type: TextInputType.emailAddress,
                            controller: passwordController,
                            securityType: InputSecurityType.password,
                            onChanged: (String value) {
                              onChangeInut();
                            },
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 28),
                          Button(
                            title: "Login",
                            onPress: onLoggin,
                            enable: enableLogin.value,
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
                                  style: TextStyles
                                      .regularText14.colorPrimaryGray
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
              ))),
    );
  }
}
