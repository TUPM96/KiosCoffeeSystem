// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_goods_receipt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddGoodsReceiptStore on _AddGoodsReceiptStore, Store {
  late final _$postGoodsReceiptAtom =
      Atom(name: '_AddGoodsReceiptStore.postGoodsReceipt', context: context);

  @override
  ObservableFuture<dynamic> get postGoodsReceipt {
    _$postGoodsReceiptAtom.reportRead();
    return super.postGoodsReceipt;
  }

  @override
  set postGoodsReceipt(ObservableFuture<dynamic> value) {
    _$postGoodsReceiptAtom.reportWrite(value, super.postGoodsReceipt, () {
      super.postGoodsReceipt = value;
    });
  }

  late final _$goodsReceiptAtom =
      Atom(name: '_AddGoodsReceiptStore.goodsReceipt', context: context);

  @override
  GoodsReceipt? get goodsReceipt {
    _$goodsReceiptAtom.reportRead();
    return super.goodsReceipt;
  }

  @override
  set goodsReceipt(GoodsReceipt? value) {
    _$goodsReceiptAtom.reportWrite(value, super.goodsReceipt, () {
      super.goodsReceipt = value;
    });
  }

  late final _$fetchProductsResAtom =
      Atom(name: '_AddGoodsReceiptStore.fetchProductsRes', context: context);

  @override
  ObservableFuture<dynamic> get fetchProductsRes {
    _$fetchProductsResAtom.reportRead();
    return super.fetchProductsRes;
  }

  @override
  set fetchProductsRes(ObservableFuture<dynamic> value) {
    _$fetchProductsResAtom.reportWrite(value, super.fetchProductsRes, () {
      super.fetchProductsRes = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_AddGoodsReceiptStore.products', context: context);

  @override
  List<String> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<String> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$fetchContainersResAtom =
      Atom(name: '_AddGoodsReceiptStore.fetchContainersRes', context: context);

  @override
  ObservableFuture<dynamic> get fetchContainersRes {
    _$fetchContainersResAtom.reportRead();
    return super.fetchContainersRes;
  }

  @override
  set fetchContainersRes(ObservableFuture<dynamic> value) {
    _$fetchContainersResAtom.reportWrite(value, super.fetchContainersRes, () {
      super.fetchContainersRes = value;
    });
  }

  late final _$containersAtom =
      Atom(name: '_AddGoodsReceiptStore.containers', context: context);

  @override
  List<ContainerDropdownData> get containers {
    _$containersAtom.reportRead();
    return super.containers;
  }

  @override
  set containers(List<ContainerDropdownData> value) {
    _$containersAtom.reportWrite(value, super.containers, () {
      super.containers = value;
    });
  }

  late final _$fetchPackingResAtom =
      Atom(name: '_AddGoodsReceiptStore.fetchPackingRes', context: context);

  @override
  ObservableFuture<dynamic> get fetchPackingRes {
    _$fetchPackingResAtom.reportRead();
    return super.fetchPackingRes;
  }

  @override
  set fetchPackingRes(ObservableFuture<dynamic> value) {
    _$fetchPackingResAtom.reportWrite(value, super.fetchPackingRes, () {
      super.fetchPackingRes = value;
    });
  }

  late final _$packingsAtom =
      Atom(name: '_AddGoodsReceiptStore.packings', context: context);

  @override
  List<PackingContent> get packings {
    _$packingsAtom.reportRead();
    return super.packings;
  }

  @override
  set packings(List<PackingContent> value) {
    _$packingsAtom.reportWrite(value, super.packings, () {
      super.packings = value;
    });
  }

  late final _$containerListAtom =
      Atom(name: '_AddGoodsReceiptStore.containerList', context: context);

  @override
  List<String> get containerList {
    _$containerListAtom.reportRead();
    return super.containerList;
  }

  @override
  set containerList(List<String> value) {
    _$containerListAtom.reportWrite(value, super.containerList, () {
      super.containerList = value;
    });
  }

  late final _$productReceiptDataListAtom = Atom(
      name: '_AddGoodsReceiptStore.productReceiptDataList', context: context);

  @override
  List<ProductReceiptData> get productReceiptDataList {
    _$productReceiptDataListAtom.reportRead();
    return super.productReceiptDataList;
  }

  @override
  set productReceiptDataList(List<ProductReceiptData> value) {
    _$productReceiptDataListAtom
        .reportWrite(value, super.productReceiptDataList, () {
      super.productReceiptDataList = value;
    });
  }

  late final _$postNewReceiptAsyncAction =
      AsyncAction('_AddGoodsReceiptStore.postNewReceipt', context: context);

  @override
  Future<dynamic> postNewReceipt() {
    return _$postNewReceiptAsyncAction.run(() => super.postNewReceipt());
  }

  late final _$fetchDropdownProductsAsyncAction = AsyncAction(
      '_AddGoodsReceiptStore.fetchDropdownProducts',
      context: context);

  @override
  Future<dynamic> fetchDropdownProducts() {
    return _$fetchDropdownProductsAsyncAction
        .run(() => super.fetchDropdownProducts());
  }

  late final _$fetchDropdownContainersAsyncAction = AsyncAction(
      '_AddGoodsReceiptStore.fetchDropdownContainers',
      context: context);

  @override
  Future<dynamic> fetchDropdownContainers() {
    return _$fetchDropdownContainersAsyncAction
        .run(() => super.fetchDropdownContainers());
  }

  late final _$fetchPackingDataAsyncAction =
      AsyncAction('_AddGoodsReceiptStore.fetchPackingData', context: context);

  @override
  Future<dynamic> fetchPackingData() {
    return _$fetchPackingDataAsyncAction.run(() => super.fetchPackingData());
  }

  late final _$_AddGoodsReceiptStoreActionController =
      ActionController(name: '_AddGoodsReceiptStore', context: context);

  @override
  List<String> retrieveFromEnum(DropdownListType type) {
    final _$actionInfo = _$_AddGoodsReceiptStoreActionController.startAction(
        name: '_AddGoodsReceiptStore.retrieveFromEnum');
    try {
      return super.retrieveFromEnum(type);
    } finally {
      _$_AddGoodsReceiptStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postGoodsReceipt: ${postGoodsReceipt},
goodsReceipt: ${goodsReceipt},
fetchProductsRes: ${fetchProductsRes},
products: ${products},
fetchContainersRes: ${fetchContainersRes},
containers: ${containers},
fetchPackingRes: ${fetchPackingRes},
packings: ${packings},
containerList: ${containerList},
productReceiptDataList: ${productReceiptDataList}
    ''';
  }
}
