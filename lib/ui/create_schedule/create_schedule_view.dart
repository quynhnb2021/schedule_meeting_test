import 'dart:math';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';
import 'package:schedule_meeting/ui/base/common/select_duration_popup.dart';
import 'package:schedule_meeting/ui/base/component/app_bar_custom/app_bar_custom.dart';
import 'package:schedule_meeting/ui/base/component/button/button.dart';
import 'package:schedule_meeting/ui/base/component/loading/container_with_loading.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/create_schedule/create_schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:schedule_meeting/ui/home_list_schedule/home_list_schedule_view_model.dart';
import 'package:schedule_meeting/ui/themes/custom_container.dart';

class CreateScheduleView extends BaseView<CreateScheduleViewViewModel> {
  final List<Meeting> datas;
  const CreateScheduleView({required this.datas, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final router = useRouter();
    // final HomeViewModel homeViewModel = ref.watch(homeViewModelProvider);

    final CreateScheduleViewViewModel viewModel =
        ref.watch(createScheduleViewModelProvider);

    Future<void> onCreateSchedule() async {
      viewModel.createScheduleNew(context, datas);
    }

    useEffectAsync(() async {
      await viewModel.getDate(context);
    });

    return Scaffold(
      appBar: AppBarCustom(
        title: Text(
          'Create Schedule',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppFunc().responsiveUI(width)),
          child: ContainerWithLoading(
              provider: createScheduleViewModelProvider,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Choose Date",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        Expanded(
                          child: CustomBorderContainer(
                            callBack: () {
                              viewModel.selectDate();
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.dateCurrent,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Icon(
                                  Icons.date_range,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Choose Duration",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        CustomBorderContainer(
                          width: 100,
                          callBack: () {
                            showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => SelectDurationPopup(
                                viewModel: viewModel,
                                title: viewModel.duration,
                                datas: viewModel.durations.reversed.toList(),
                                onTap: (s) {
                                  viewModel.updateDuration(s);
                                },
                              ),
                            );
                          },
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${viewModel.duration} m',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Choose Partner",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        Expanded(
                          child: CustomBorderContainer(
                            callBack: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => SelectDurationPopup(
                                  viewModel: viewModel,
                                  type: false,
                                  title: viewModel.partnerName,
                                  datas: viewModel.partners,
                                  onTap: (s) {
                                    viewModel.updatePartner(s);
                                  },
                                ),
                              );
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.partnerName,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Choose Timeslot",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        Expanded(
                          child: CustomBorderContainer(
                            callBack: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => SelectDurationPopup(
                                  viewModel: viewModel,
                                  type: false,
                                  title: viewModel.timeSlot,
                                  datas: viewModel.timeSlots,
                                  onTap: (s) {
                                    viewModel.updateTimeslot(s);
                                  },
                                ),
                              );
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.timeSlot,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 24.0),
                      child: Button(
                        title: "Create Schedule",
                        onPress: onCreateSchedule,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
