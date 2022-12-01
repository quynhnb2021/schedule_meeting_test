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
  // DisplayProfileResponse inforProfile;
  const HomeScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();
    final HomeScheduleViewModel blogViewModel =
        ref.watch(homeScheduleViewModelProvider);
    useEffectAsync(() async {
      await blogViewModel.getBlogs(null, null);
    });
    return Scaffold(
      appBar: AppBarCustom(
        height: 0,
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SearchView(
                        onActionDone: (s) {
                          blogViewModel.getBlogs(null, s);
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: blogViewModel.type == ''
                          ? AppColors.backgroundColorButton
                          : Theme.of(context).backgroundColor,
                      child: TextButton(
                        onPressed: () {
                          // blogViewModel.choseType(2);
                        },
                        child: Text("List Schedules",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ),
                    blogViewModel.schedulesStream != null
                        ? StreamBuilder<QuerySnapshot>(
                            stream: blogViewModel.schedulesStream,
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
                                  return SchedulesTile(
                                    date: data['date'],
                                    duration: data['duration'],
                                    partnerName: data['partnerName'] ?? '',
                                    timeSlot: data['timeSlot'],
                                  );
                                }).toList(),
                              );
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          router.push(const CreateScheduleRoute());
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
  String date, duration, partnerName, timeSlot;
  SchedulesTile(
      {required this.date,
      required this.duration,
      required this.partnerName,
      required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text(
                  duration,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  partnerName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(timeSlot)
              ],
            ),
          )
        ],
      ),
    );
  }
}
