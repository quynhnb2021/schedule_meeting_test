import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';
import 'package:schedule_meeting/ui/base/search_list_view.dart';

class SelectDurationPopup extends HookConsumerWidget {
  final bool timeSlot;
  final String title;
  final bool type;

  final List<String> datas;
  final Function(String s) onTap;
  final BaseViewModel viewModel;
  const SelectDurationPopup({
    required this.title,
    this.type = true,
    this.timeSlot = false,
    required this.datas,
    required this.onTap,
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (() {
        AppFunc.hideKeyboard(context);
      }),
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppFunc().responsiveUI(width)),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 3,
              child: SearchListView(
                isSinkWrap: true,
                viewModel: viewModel,
                filterData: datas,
                // headerSearchList: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //         filterData:
                //       },
                //       child: Text(
                //         "Time available",
                //         textAlign: TextAlign.end,
                //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //               decoration: TextDecoration.underline,
                //             ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 36,
                //     ),
                //   ],
                // ),
                itemBuilder: (context, index, filter) {
                  final item = datas
                      .where((e) => e.toLowerCase().contains(filter))
                      .toList()[index];
                  return GestureDetector(
                    onTap: () {
                      onTap(datas[index]);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              type ? '$item minutes' : item,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Visibility(
                              visible: title == item,
                              child: Icon(Icons.check,
                                  color: Theme.of(context).primaryColor))
                          // : const SizedBox()
                        ],
                      ),
                    ),
                  );
                },

                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 8,
                    ),
                    child: Divider(
                      thickness: 1,
                      height: 24,
                    ),
                  );
                },

                // ListView.separated(
                //   shrinkWrap: true,
                //   itemCount: datas.length,
                //   separatorBuilder: (BuildContext context, int index) {
                //     return const Padding(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 100,
                //         vertical: 8,
                //       ),
                //       child: Divider(
                //         thickness: 1,
                //         height: 24,
                //       ),
                //     );
                //   },
                //   itemBuilder: (context, index) => ,
              )),
        ),
      ),
    );
  }
}
