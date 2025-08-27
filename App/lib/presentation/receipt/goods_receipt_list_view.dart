import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/search_filter.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/receipt/store/goods_receipt_store.dart';
import 'package:boilerplate/utils/conversion/conversion.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ReceiptListScreen extends StatefulWidget {
  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  //stores:---------------------------------------------------------------------
  final GoodsReceiptStore _goodsStore = getIt<GoodsReceiptStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_goodsStore.loading && _goodsStore.packingReceiveList.length == 0) {
      _goodsStore.getPosts();
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
            locale.translate('home_shipment'),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.background,
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
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
    return SearchFilter(
      onFilterMode: () {
        _goodsStore.filterByDate();
      },
      onSearchMode: (query) {
        _goodsStore.detailQuery = query;
        _goodsStore.searchProductData(query).then((value) {
          setState(() {});
        });
      },
      store: _goodsStore,
      startDate: _goodsStore.startDate,
      endDate: _goodsStore.endDate,
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _goodsStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    final locale = context.appLocale;
    return _goodsStore.goodsReceiptData != null
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: _goodsStore.packingReceiveList.length,
            separatorBuilder: (context, position) {
              return Divider();
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
    var item = _goodsStore.packingReceiveList[position];
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
          trailing: PopupMenuButton(
            elevation: 4.0,
            constraints:
                BoxConstraints(minWidth: Dimens.screenWidth(context) * .1),
            position: PopupMenuPosition.over,
            offset: Offset(0.0, -16.0),
            padding: EdgeInsets.all(0),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  height: Dimens.screenHeight(context) * .04,
                  value: '0',
                  child: Text(
                    'Edit Data',
                    style: context.textTheme.bodySmall,
                  ),
                  // onTap: () => onSelected,
                ),
                PopupMenuItem(
                  height: Dimens.screenHeight(context) * .04,
                  value: '1',
                  child: Text(
                    'Hapus Data',
                    style: context.textTheme.bodySmall,
                  ),
                  onTap: () {
                    _buildModalConfirm(position);
                  },
                )
              ];
            },
            child: FractionallySizedBox(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(-16.0, 0),
                child: Icon(Icons.more_vert),
              ),
              widthFactor: .05,
            ),
          ),
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
                      item.markingNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style:
                          context.textTheme.bodyMedium!.copyWith(fontSize: 11),
                    ),
                    Text(
                      item.createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style:
                          context.textTheme.bodyMedium!.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                Dimens.vSpaceTiny,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.receiveNote,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      item.containerNoInternal,
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
                    Text(
                      item.product,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: context.textTheme.titleMedium,
                    ),
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
                Divider(
                  thickness: 1.5,
                  indent: 0.0,
                ),
                Text(
                  'Notes:',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_goodsStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_goodsStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    final locale = context.appLocale;
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: locale.translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  //modal popup
  _buildModalConfirm(int pos) async {
    final locale = context.appLocale;

    await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          width: double.infinity,
          height: 220,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            color: Colors.white,
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Menghapus Pengiriman',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(
                color: hexToColor('#EAEAEA'),
                thickness: 1.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Apakah Anda yakin ingin menghapus pengiriman ini?',
                      style: context.textTheme.bodyLarge!.copyWith(
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 36,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: context.primary,
                          width: 2,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Tidak',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          _goodsStore.removeData(pos);
                          Navigator.of(context).pop(true);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: context.primary,
                        ),
                        child: Text(
                          'Iya',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      FlushbarHelper.createInformation(
        message: locale.translate("success_delete"),
        duration: Duration(seconds: 3),
      )..show(context);
      setState(() {});
    });
  }
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
