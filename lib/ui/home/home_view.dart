import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/home_list_schedule/home_list_schedule_view.dart';
import 'package:schedule_meeting/ui/create_schedule/create_schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:schedule_meeting/ui/home/home_view_model.dart';
import 'package:schedule_meeting/ui/home/tab_type.dart';
import 'package:schedule_meeting/ui/schedule_date/schedule_date_view.dart';
import 'package:schedule_meeting/ui/setting_pages/setting/setting_view.dart';
import 'package:schedule_meeting/ui/themes/app_color.dart';
import 'package:schedule_meeting/ui/themes/text_styles.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel viewModel = ref.watch(homeViewModelProvider);
    final idMain = useState(viewModel.bottomSelectedItem);

    useEffectAsync(() async {
      print("Inited");
      // await viewModel.configureOneSignal();
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: [
          // const OverviewView(),
          // const FleetView(),
          const HomeScheduleView(),
          const ScheduleDateView(),

          const SettingView(),
        ][idMain.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: idMain.value,
          onTap: (index) {
            idMain.value = index;
          },
          selectedItemColor: AppColors.colorOrange,
          unselectedItemColor: AppColors.colorDivider,
          selectedLabelStyle: TextStyles.regularText12.w500.colorPrimaryOrange,
          unselectedLabelStyle: TextStyles.regularText12.w500,
          type: BottomNavigationBarType.fixed,
          items: TabType.values
              .map(
                (type) => _bottomNavigationBarItem(
                  icon: mapTabTypeToIconUri(type),
                  label: mapTabTypeToLabel(type),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required Widget icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: icon,
      label: label,
    );
  }
}
