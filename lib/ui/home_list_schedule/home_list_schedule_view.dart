import 'dart:math';

import 'package:schedule_meeting/route/app_route.gr.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';
import 'package:schedule_meeting/ui/base/common/network_image.dart';
import 'package:schedule_meeting/ui/base/common/search_view.dart';
import 'package:schedule_meeting/ui/base/component/app_bar_custom/app_bar_custom.dart';
import 'package:schedule_meeting/ui/base/component/loading/container_with_loading.dart';
import 'package:schedule_meeting/ui/base/hook/use_effect_async.dart';
import 'package:schedule_meeting/ui/base/hook/use_router.dart';
import 'package:schedule_meeting/ui/home_list_schedule/home_list_schedule_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/di/view_model_provider.dart';
import 'package:schedule_meeting/ui/base/base_view.dart';
import 'package:schedule_meeting/ui/themes/app_color.dart';

class HomeScheduleView extends BaseView<HomeScheduleViewModel> {
  const HomeScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();
    final HomeScheduleViewModel viewModel =
        ref.watch(homeScheduleViewModelProvider);
    useEffectAsync(() async {
      await viewModel.getBlogs(null);
    });
    return Scaffold(
      appBar: AppBarCustom(
        title: Text(
          'List Schedules',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        showBack: false,
      ),
      body: SafeArea(
        child: ContainerWithLoading(
          provider: settingViewModelProvider,
          child: GestureDetector(
            onTap: (() => AppFunc.hideKeyboard(context)),
            child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: SearchView(
                    //     onActionDone: (s) {
                    //       blogViewModel.getBlogs(null, s);
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   color: viewModel.type == ''
                    //       ? AppColors.backgroundColorButton
                    //       : Theme.of(context).backgroundColor,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // blogViewModel.choseType(2);
                    //     },
                    //     child: Text("List Schedules",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .titleMedium!
                    //             .copyWith(color: Colors.black)),
                    //   ),
                    // ),
                    viewModel.schedulesStream != null
                        ? StreamBuilder<QuerySnapshot>(
                            stream: viewModel.schedulesStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              return ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                reverse: true,
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  viewModel.datas.add(Meeting(
                                      date: data['date'],
                                      duration: data['duration'],
                                      partner: data['partnerName'],
                                      timeSlot: data['timeSlot']));
                                  return SchedulesTile(
                                    date: data['date'],
                                    duration: data['duration'],
                                    partnerName: data['partnerName'] ?? '',
                                    timeSlot: data['timeSlot'],
                                    i: 0,
                                  );
                                }).toList(),
                              );
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(viewModel.datas);
          router.push(CreateScheduleRoute(datas: viewModel.datas));
        },
        tooltip: 'Add Schedule task',
        child: const Icon(Icons.add),
      ),
    );
  }

  buildItem(BuildContext context) => Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.only(top: 43, left: 24, right: 24, bottom: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Schedule",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ]),
      );
}

class SchedulesTile extends StatelessWidget {
  final String date, duration, partnerName, timeSlot;
  final int i;
  SchedulesTile({
    required this.date,
    required this.duration,
    required this.partnerName,
    required this.timeSlot,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    final nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    final n = Random().nextInt(100) + 10;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: n.isEven
                    ? Color(0xFF00FF19).withOpacity(0.8)
                    : Color(0xFF3F00C3).withOpacity(0.8),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            partnerName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${duration} minutes',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 80,
                      color: AppColors.bgButtonDarkColor,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            date,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            timeSlot,
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
