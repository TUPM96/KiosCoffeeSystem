import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/receipt/add_receipt/store/add_goods_receipt_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class AddProductReceiptScreen extends StatefulWidget {
  const AddProductReceiptScreen({super.key});

  @override
  State<AddProductReceiptScreen> createState() =>
      _AddProductReceiptScreenState();
}

class _AddProductReceiptScreenState extends State<AddProductReceiptScreen> {
  //stores:
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final AddGoodsReceiptStore _addGoodsReceiptStore =
      getIt<AddGoodsReceiptStore>();

  late var scrollController;

  late var bottomSheetScrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    bottomSheetScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final locale = context.appLocale;
    return AppBar(
      primary: true,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.chevron_left, color: Colors.black, size: 32),
      ),
      title: Column(
        children: [
          Text(
            locale.translate('add_receipt'),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.background,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            style: context.elevatedButtonTheme.style!,
            onPressed: () {
              var listType = DropdownListType.containerList;
              var bottomSheetTitle = _getDropdownTitle(listType);
              var rnList = _addGoodsReceiptStore.retrieveFromEnum(listType);
              _buildBottomSheet(dropdownList: rnList, title: bottomSheetTitle);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. Container'),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        Expanded(child: _buildHorizontalDataTable()),
      ],
    );
  }

  _buildHorizontalDataTable() {
    var dataList = _addGoodsReceiptStore.productReceiptDataList;
    return HorizontalDataTable(
      leftHandSideColumnWidth: context.mediaQuery.size.width * .5,
      rightHandSideColumnWidth: context.mediaQuery.size.width,
      itemCount: dataList.length,
      itemExtent: 70,
      scrollPhysics: AlwaysScrollableScrollPhysics(),
      elevation: 0.0,
      leftSideItemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  style: context.textTheme.labelSmall!
                      .copyWith(color: Colors.black),
                  controller: TextEditingController(
                      text: dataList[index].receivingNumber),
                  readOnly: true,
                  onTap: () async {
                    var listType = DropdownListType.receivingNumber;
                    var bottomSheetTitle = _getDropdownTitle(listType);
                    var rnList =
                        _addGoodsReceiptStore.retrieveFromEnum(listType);
                    _buildBottomSheet(
                        dropdownList: rnList, title: bottomSheetTitle);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      hintText: 'Select',
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 10,
                      ),
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                      hintStyle: context.textTheme.labelMedium),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  style: context.textTheme.labelSmall!
                      .copyWith(color: Colors.black),
                  controller:
                      TextEditingController(text: dataList[index].product),
                  onTap: () async {
                    var listType = DropdownListType.products;
                    var products =
                        _addGoodsReceiptStore.retrieveFromEnum(listType);
                    var bottomSheetTitle = _getDropdownTitle(listType);
                    _buildBottomSheet(
                        dropdownList: products, title: bottomSheetTitle);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      hintText: 'Select',
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 10,
                      ),
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                      hintStyle: context.textTheme.labelMedium),
                ),
              ),
            ),
          ],
        );
      },
      rightSideItemBuilder: (context, index) {
        var value = _addGoodsReceiptStore.productReceiptDataList[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 60,
              width: context.mediaQuery.size.width * .23,
              alignment: FractionalOffset.center,
              child: Text(value.expectedQc.toString()),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: context.mediaQuery.size.width * .23,
              child: TextField(
                style:
                    context.textTheme.labelSmall!.copyWith(color: Colors.black),
                controller: TextEditingController(
                    text: dataList[index].acceptedQc.toString()),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    hintText: '',
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 10,
                    ),
                    hintStyle: context.textTheme.labelMedium),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: context.mediaQuery.size.width * .25,
              child: TextField(
                style:
                    context.textTheme.labelSmall!.copyWith(color: Colors.black),
                controller: TextEditingController(
                    text: dataList[index].notes.toString()),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    hintText: '',
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 10,
                    ),
                    hintStyle: context.textTheme.labelMedium),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              color: Colors.grey,
              onPressed: () {},
            )
          ],
        );
      },
      isFixedHeader: true,
      headerWidgets: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 2.09),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.zero,
                  height: 56,
                  color: context.colorScheme.primary,
                  alignment: Alignment.center,
                  child: Text(
                    'Receiving Number',
                    style: context.textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.zero,
                  height: 56,
                  color: context.colorScheme.primary,
                  alignment: Alignment.center,
                  child: Text(
                    'Product',
                    style: context.textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: context.colorScheme.primary,
          width: context.mediaQuery.size.width / 4,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: Text(
            'Expected QC',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: context.mediaQuery.size.width / 4,
          alignment: Alignment.center,
          color: context.colorScheme.primary,
          child: Text(
            'QC diterima',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: context.mediaQuery.size.width / 4,
          alignment: Alignment.center,
          color: context.colorScheme.primary,
          child: Text(
            'Notes',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          color: context.colorScheme.primary,
          width: context.mediaQuery.size.width / 6,
          height: 56,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            'Action',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
      horizontalScrollPhysics: AlwaysScrollableScrollPhysics(),
      // rowSeparatorWidget: Divider(color: Colors.black, thickness: 2.0),
    );
  }

  _buildBottomSheet(
      {required List<dynamic> dropdownList, required String title}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            expand: true,
            initialChildSize: .4,
            minChildSize: .25,
            maxChildSize: .4,
            controller: DraggableScrollableController(),
            snap: true,
            builder: (context, controller) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Dimens.vSpaceMedium,
                    Container(
                      alignment: FractionalOffset.center,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(title),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          padding: EdgeInsets.zero,
                          itemCount: dropdownList.length,
                          itemExtent: 50,
                          itemBuilder: (context, index) {
                            var value = dropdownList[index];
                            return InkWell(
                              onTap: () {
                                context.navigator.pop(value);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).then((value) => print(value));
  }

  _getDropdownTitle(DropdownListType type) {
    switch (type) {
      case DropdownListType.products:
        return 'Products';
      case DropdownListType.receivingNumber:
        return 'Receiving Number';
      case DropdownListType.containerList:
        return 'Container';
    }
  }
}
