// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GoodsReceiptStore on _GoodsReceiptStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_GoodsReceiptStore.loading'))
      .value;

  late final _$fetchPostsFutureAtom =
      Atom(name: '_GoodsReceiptStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<dynamic> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<dynamic> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$goodsReceiptDataAtom =
      Atom(name: '_GoodsReceiptStore.goodsReceiptData', context: context);

  @override
  GoodsReceiptData? get goodsReceiptData {
    _$goodsReceiptDataAtom.reportRead();
    return super.goodsReceiptData;
  }

  @override
  set goodsReceiptData(GoodsReceiptData? value) {
    _$goodsReceiptDataAtom.reportWrite(value, super.goodsReceiptData, () {
      super.goodsReceiptData = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_GoodsReceiptStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$packingReceiveListAtom =
      Atom(name: '_GoodsReceiptStore.packingReceiveList', context: context);

  @override
  List<PackingReceiveModel> get packingReceiveList {
    _$packingReceiveListAtom.reportRead();
    return super.packingReceiveList;
  }

  @override
  set packingReceiveList(List<PackingReceiveModel> value) {
    _$packingReceiveListAtom.reportWrite(value, super.packingReceiveList, () {
      super.packingReceiveList = value;
    });
  }

  late final _$filteredPackingReceiveListAtom = Atom(
      name: '_GoodsReceiptStore.filteredPackingReceiveList', context: context);

  @override
  List<PackingReceiveModel> get filteredPackingReceiveList {
    _$filteredPackingReceiveListAtom.reportRead();
    return super.filteredPackingReceiveList;
  }

  @override
  set filteredPackingReceiveList(List<PackingReceiveModel> value) {
    _$filteredPackingReceiveListAtom
        .reportWrite(value, super.filteredPackingReceiveList, () {
      super.filteredPackingReceiveList = value;
    });
  }

  late final _$startDateAtom =
      Atom(name: '_GoodsReceiptStore.startDate', context: context);

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: '_GoodsReceiptStore.endDate', context: context);

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$detailQueryAtom =
      Atom(name: '_GoodsReceiptStore.detailQuery', context: context);

  @override
  String get detailQuery {
    _$detailQueryAtom.reportRead();
    return super.detailQuery;
  }

  @override
  set detailQuery(String value) {
    _$detailQueryAtom.reportWrite(value, super.detailQuery, () {
      super.detailQuery = value;
    });
  }

  late final _$getPostsAsyncAction =
      AsyncAction('_GoodsReceiptStore.getPosts', context: context);

  @override
  Future<dynamic> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
goodsReceiptData: ${goodsReceiptData},
success: ${success},
packingReceiveList: ${packingReceiveList},
filteredPackingReceiveList: ${filteredPackingReceiveList},
startDate: ${startDate},
endDate: ${endDate},
detailQuery: ${detailQuery},
loading: ${loading}
    ''';
  }
}
