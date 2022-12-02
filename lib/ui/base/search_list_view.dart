import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';
import 'package:schedule_meeting/ui/base/common/search_view.dart';
import 'package:shimmer/shimmer.dart';

class SearchListView<T> extends HookConsumerWidget {
  final List<String> filterData;
  final Widget Function(BuildContext context, int index, String filter)
      itemBuilder;
  final ScrollPhysics scrollPhysics;
  final Widget? headerSearchList;
  final IndexedWidgetBuilder? separatorBuilder;
  final VoidCallback? onRefresh;
  final BaseViewModel viewModel;
  final double defaultHeightShimmer;
  final bool visibleSearch;
  final bool isSinkWrap;
  final TextEditingController? controllerTF;
  final Function(bool)? onFocus;

  const SearchListView(
      {Key? key,
      required this.filterData,
      required this.itemBuilder,
      this.scrollPhysics =
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      this.separatorBuilder,
      this.onRefresh,
      required this.viewModel,
      this.defaultHeightShimmer = 80,
      this.headerSearchList,
      this.visibleSearch = true,
      this.isSinkWrap = false,
      this.controllerTF,
      this.onFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = useTextEditingController();
    if (controllerTF != null) {
      controller.text = controllerTF!.text;
    }

    // final DartModeViewViewModel dartModeViewViewModel =
    //     ref.watch(dartModeViewModelProvider);
    return Column(
      children: [
        if (visibleSearch)
          Center(
            child: SizedBox(
              width: 300,
              child: Focus(
                onFocusChange: onFocus,
                child: SearchView(
                  controller: controllerTF ?? controller,
                  onActionDone: (_) {
                    viewModel.updateWidget();
                  },
                  onActionChanged: (s) {
                    controller.value = TextEditingValue(
                      text: s,
                      selection: TextSelection.collapsed(offset: s.length),
                    );
                    // controller.text = controller.value.text;
                    viewModel.updateWidget();
                  },
                ),
              ),
            ),
          ),
        if (headerSearchList != null) headerSearchList!,
        if (viewModel.isBusy)
          Expanded(
              child: ListView.builder(
            shrinkWrap: isSinkWrap,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) => SizedBox(
              height: defaultHeightShimmer,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).backgroundColor,
                highlightColor: Theme.of(context).shadowColor,
                enabled: true,
                child: Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(),
                ),
              ),
            ),
          ))
        else if (filterData
            .where(
              (e) => e.toLowerCase().contains(controller.text.toLowerCase()),
            )
            .isEmpty)
          Expanded(
            child: Center(
              child: Text(
                "No data.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: RefreshIndicator(
                onRefresh: () async {
                  if (onRefresh != null) {
                    onRefresh!();
                  }
                },
                child: separatorBuilder != null
                    ? ListView.separated(
                        shrinkWrap: isSinkWrap,
                        itemCount: filterData
                            .where(
                              (e) => e
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase()),
                            )
                            .length,
                        itemBuilder: (context, index) {
                          final totalItem = filterData
                              .where(
                                (e) => e
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()),
                              )
                              .length;
                          return itemBuilder(context, totalItem - 1 - index,
                              controller.text.toLowerCase());
                        },
                        physics: scrollPhysics,
                        separatorBuilder: separatorBuilder!,
                      )
                    : ListView.builder(
                        shrinkWrap: isSinkWrap,
                        itemCount: filterData
                            .where((e) => e
                                .toLowerCase()
                                .contains(controller.text.toLowerCase()))
                            .length,
                        itemBuilder: (context, index) {
                          final totalItem = filterData
                              .where(
                                (e) => e
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()),
                              )
                              .length;
                          return itemBuilder(context, totalItem - 1 - index,
                              controller.text.toLowerCase());
                        },
                        physics: scrollPhysics,
                      ),
              ),
            ),
          )
      ],
    );
  }
}

class ListNoItem extends StatelessWidget {
  const ListNoItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/fleets/ic_robot.png",
          width: 37,
          height: 54,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          height: 12,
        ),
        //Todo
        Text(
          "No data.",
          style: Theme.of(context).textTheme.displaySmall,
        )
      ],
    );
  }
}
