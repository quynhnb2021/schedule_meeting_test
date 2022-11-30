import 'dart:math';

import 'package:schedule_meeting/ui/base/component/app_bar_custom/app_bar_custom.dart';
import 'package:schedule_meeting/ui/base/component/loading/container_with_loading.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/create_schedule/create_schedule_view_model.dart';
import 'package:schedule_meeting/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:time_planner/time_planner.dart';

class CreateScheduleView extends BaseView<CreateScheduleViewViewModel> {
  // DisplayProfileResponse inforProfile;
  const CreateScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();

    final enableSave = useState(false);
    final HomeViewModel homeViewModel = ref.watch(homeViewModelProvider);

    final CreateScheduleViewViewModel viewModel =
        ref.watch(createBlogViewModelProvider);

    void _addObject(BuildContext context) {
      viewModel.addTask(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Random task added to time planner!')));
    }

    useEffectAsync(() async {
      // await viewModel.getInforProfile();
    });

    return Scaffold(
      appBar: AppBarCustom(
        height: 0,
      ),
      body: SafeArea(
        child: ContainerWithLoading(
          provider: settingViewModelProvider,
          child: Center(
            child: TimePlanner(
              startHour: 6,
              endHour: 23,
              style: TimePlannerStyle(
                // cellHeight: 60,
                // cellWidth: 60,
                showScrollBar: true,
              ),
              headers: const [
                TimePlannerTitle(
                  date: "3/10/2021",
                  title: "sunday",
                ),
                TimePlannerTitle(
                  date: "3/11/2021",
                  title: "monday",
                ),
                TimePlannerTitle(
                  date: "3/12/2021",
                  title: "tuesday",
                ),
                TimePlannerTitle(
                  date: "3/13/2021",
                  title: "wednesday",
                ),
                TimePlannerTitle(
                  date: "3/14/2021",
                  title: "thursday",
                ),
                TimePlannerTitle(
                  date: "3/15/2021",
                  title: "friday",
                ),
                TimePlannerTitle(
                  date: "3/16/2021",
                  title: "saturday",
                ),
                TimePlannerTitle(
                  date: "3/17/2021",
                  title: "sunday",
                ),
                TimePlannerTitle(
                  date: "3/18/2021",
                  title: "monday",
                ),
                TimePlannerTitle(
                  date: "3/19/2021",
                  title: "tuesday",
                ),
                TimePlannerTitle(
                  date: "3/20/2021",
                  title: "wednesday",
                ),
                TimePlannerTitle(
                  date: "3/21/2021",
                  title: "thursday",
                ),
                TimePlannerTitle(
                  date: "3/22/2021",
                  title: "friday",
                ),
                TimePlannerTitle(
                  date: "3/23/2021",
                  title: "saturday",
                ),
                TimePlannerTitle(
                  date: "3/24/2021",
                  title: "tuesday",
                ),
                TimePlannerTitle(
                  date: "3/25/2021",
                  title: "wednesday",
                ),
                TimePlannerTitle(
                  date: "3/26/2021",
                  title: "thursday",
                ),
                TimePlannerTitle(
                  date: "3/27/2021",
                  title: "friday",
                ),
                TimePlannerTitle(
                  date: "3/28/2021",
                  title: "saturday",
                ),
                TimePlannerTitle(
                  date: "3/29/2021",
                  title: "friday",
                ),
                TimePlannerTitle(
                  date: "3/30/2021",
                  title: "saturday",
                ),
              ],
              tasks: viewModel.tasks,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addObject(context),
        tooltip: 'Add random task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
