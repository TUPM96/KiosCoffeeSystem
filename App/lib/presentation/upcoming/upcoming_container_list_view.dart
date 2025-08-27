import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/container/store/container_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UpcomingContainerListView extends StatefulWidget {
  const UpcomingContainerListView({super.key});

  @override
  State<UpcomingContainerListView> createState() =>
      _UpcomingContainerListViewState();
}

class _UpcomingContainerListViewState extends State<UpcomingContainerListView> {
  final ContainerStore _containerStore = getIt<ContainerStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_containerStore.upcomingContainerLoading) {
      _containerStore.getUpcomingContainer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }

  _buildAppBar() {
    final locale = context.appLocale;
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultAppBar(trKey: 'home_upcoming_shipment', suffix: ''),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildSearchFilter(),
        Expanded(
          child: Stack(
            children: [
              _buildMainContent(),
            ],
          ),
        ),
      ],
    );
  }

  _buildSearchFilter() {
    // return SearchFilter(
    //   onSearchMode: (query) {},
    // );
    return SizedBox.shrink();
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _containerStore.upcomingContainerLoading
            ? CustomProgressIndicatorWidget()
            : Material(
                child: _buildListView(),
              );
      },
    );
  }

  Widget _buildListView() {
    final containerList = _containerStore.upcomingContainers;
    final locale = context.appLocale;
    return containerList.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: containerList.length,
            separatorBuilder: (context, position) {
              return Dimens.vSpaceSemiRegular;
            },
            itemBuilder: (context, position) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _buildListItem(position),
              );
            },
          )
        : Center(
            child: Text(
              locale.translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    var item = _containerStore.upcomingContainers[position];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(color: context.primary, width: 16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity(vertical: VisualDensity.maximumDensity),
          style: ListTileStyle.list,
          minLeadingWidth: 0.0,
          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          leading: SizedBox.square(),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'RN:' + item!.containerNumber!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: context.textTheme.headlineSmall!
                          .copyWith(fontSize: 18),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Estimasi: ',
                            style: context.textTheme.bodyMedium!
                                .copyWith(fontSize: 11),
                          ),
                          TextSpan(
                            text: item.dateTime,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                    // Text(
                    //   item.estimationTime!,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   softWrap: false,
                    //   style:
                    //       context.textTheme.bodyMedium!.copyWith(fontSize: 11),
                    // ),
                  ],
                ),
                Dimens.vSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: item.quantity.toString(),
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' ITEMS',
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: item.items.toString(),
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' QC',
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
