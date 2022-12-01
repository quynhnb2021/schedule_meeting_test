import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/common/app_func.dart';

class SelectDurationPopup extends HookConsumerWidget {
  final String title;
  final bool type;

  final List<String> datas;
  final Function(String s) onTap;
  const SelectDurationPopup({
    required this.title,
    this.type = true,
    required this.datas,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() {
        AppFunc.hideKeyboard(context);
      }),
      child: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: datas.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 8,
                  ),
                  child: Divider(
                    thickness: 1,
                    height: 24,
                  ),
                );
              },
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  onTap(datas[index]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          type ? '${datas[index]} m' : datas[index],
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Visibility(
                          visible: title == datas[index],
                          child: Icon(Icons.check,
                              color: Theme.of(context).primaryColor))
                      // : const SizedBox()
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
