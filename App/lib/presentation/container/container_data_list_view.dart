import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/container/detail/container_data_detail_view.dart';
import 'package:boilerplate/presentation/container/store/container_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ContainerDataListScreen extends StatefulWidget {
  @override
  _ContainerDataListScreenState createState() =>
      _ContainerDataListScreenState();
}

class _ContainerDataListScreenState extends State<ContainerDataListScreen> {
  //stores:---------------------------------------------------------------------
  final ContainerStore _containerStore = getIt<ContainerStore>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_containerStore.loading) {
      _containerStore.getContainerList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  //appbar methods:
  PreferredSizeWidget _buildAppBar() {
    final locale = context.appLocale;
    return AppBar(
      primary: true,
      title: Column(
        children: [
          Text(
            locale.translate('misc_container'),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.background,
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    print('len' + _containerStore.containerDataUiModel.length.toString());
    return Column(
      children: [
        _buildSearchFilter(),
        Expanded(
          child: Stack(
            children: <Widget>[
              _handleErrorMessage(),
              _buildMainContent(),
            ],
          ),
        ),
      ],
    );
  }

  _buildSearchFilter() {
    return SizedBox.shrink();
    // return SearchFilter(
    //   onSearchMode: (query) {
    //     _containerStore.detailQuery = query;
    //     _containerStore.searchContainerData(query);
    //   },
    // );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _containerStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(
                child: !_containerStore.searching
                    ? _buildListView()
                    : _buildSearchListView());
      },
    );
  }

  Widget _buildListView() {
    final containerList = _containerStore.containerDataUiModel;
    final locale = context.appLocale;
    return containerList.isEmpty
        ? Center(
            child: Text(
              locale.translate(
                'empty_container',
              ),
            ),
          )
        : ListView.builder(
            itemCount: containerList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildListItem(index),
              );
            },
          );
  }

  Widget _buildSearchListView() {
    final containerList = _containerStore.filteredContainerDataUiModel;
    final locale = context.appLocale;
    return containerList.isEmpty
        ? Center(
            child: Text(
              locale.translate(
                'empty_container',
              ),
            ),
          )
        : ListView.builder(
            itemCount: containerList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildListItem(index),
              );
            },
          );
  }

  Widget _buildListItem(int position) {
    final containerList = _containerStore.containerDataUiModel;
    final item = containerList[position];
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
          onTap: () {
            context.navigator.push(
              MaterialPageRoute(
                builder: (context) {
                  return ContainerDataDetailView(
                    containerName: item.containerNumber!,
                    containerId: item.id!,
                  );
                },
              ),
            );
          },
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
                      'No. ' + item!.containerNumber!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: context.textTheme.titleMedium,
                    ),
                    Text(
                      item.dateTime!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style:
                          context.textTheme.bodyMedium!.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                Dimens.vSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: item.items.toString(),
                              style: context.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ' ITEMS',
                              style: context.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: item.quantity.toString(),
                              style: context.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ' QC', style: context.textTheme.titleMedium)
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return SizedBox.shrink();
  }

  // // General Methods:-----------------------------------------------------------
  // _showErrorMessage(String message) {
  //   final locale = context.appLocale;
  //   Future.delayed(Duration(milliseconds: 0), () {
  //     if (message.isNotEmpty) {
  //       FlushbarHelper.createError(
  //         message: message,
  //         title: locale.translate('home_tv_error'),
  //         duration: Duration(seconds: 3),
  //       )..show(context);
  //     }
  //   });

  //   return SizedBox.shrink();
  // }
}

class TileClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 0, 100, 100),
      Radius.circular(100),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return true;
  }
}
