// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/entity/receipt/packing_response.dart';
import 'package:boilerplate/domain/usecase/receipt/add_receipt_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_containers_dropdown_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_packing_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_products_dropdown_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'add_goods_receipt_store.g.dart';

class AddGoodsReceiptStore = _AddGoodsReceiptStore with _$AddGoodsReceiptStore;

abstract class _AddGoodsReceiptStore with Store {
  _AddGoodsReceiptStore(
      this._addGoodsReceiptUseCase,
      this._fetchProductsDropdownUseCase,
      this._fetchContainersDropdownUseCase,
      this._fetchPackingUseCase,
      this.errorStore) {
    _setupDisposers();
  }

  //usecases
  final AddGoodsReceiptUseCase _addGoodsReceiptUseCase;

  final FetchProductsDropdownUsecase _fetchProductsDropdownUseCase;

  final FetchContainersDropdownUseCase _fetchContainersDropdownUseCase;

  final FetchPackingUseCase _fetchPackingUseCase;

  //store
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() async {
    _disposers = [
      autorun((_) => fetchDropdownProducts()),
      autorun((_) => fetchDropdownContainers()),
      autorun((_) => fetchPackingData()),
    ];
  }

  static ObservableFuture<bool> isPostSuccess = ObservableFuture.value(true);

  @observable
  ObservableFuture<dynamic> postGoodsReceipt =
      ObservableFuture<bool>(_AddGoodsReceiptStore.isPostSuccess);

  @observable
  GoodsReceipt? goodsReceipt;

  final List<String> rnList = [
    'RN-10001',
    'RN-10002',
    'RN-10003',
    'RN-10004',
    'RN-10005',
    'RN-10006',
    'RN-10007',
    'RN-10008',
    'RN-10009',
  ];

  @observable
  ObservableFuture<dynamic> fetchProductsRes = ObservableFuture.value(null);

  @observable
  List<String> products = [];

  @observable
  ObservableFuture<dynamic> fetchContainersRes = ObservableFuture.value(null);

  @observable
  List<ContainerDropdownData> containers = [];

  @observable
  ObservableFuture<dynamic> fetchPackingRes = ObservableFuture.value(null);

  @observable
  List<PackingContent> packings = [];

  @observable
  List<String> containerList = [];

  @observable
  List<ProductReceiptData> productReceiptDataList = [
    ProductReceiptData(
        receivingNumber: '',
        product: '',
        expectedQc: 3,
        acceptedQc: 0,
        notes: ''),
  ];

  @action
  List<String> retrieveFromEnum(DropdownListType type) {
    switch (type) {
      case DropdownListType.products:
        return products;
      case DropdownListType.receivingNumber:
        return rnList;
      case DropdownListType.containerList:
        return containerList;
    }
  }

  @action
  Future postNewReceipt() async {
    final future = _addGoodsReceiptUseCase.call(params: goodsReceipt!);
    postGoodsReceipt = ObservableFuture(future);

    future.then((value) {}).catchError((err) {
      errorStore.errorMessage = DioErrorUtil.handleError(err);
    });
  }

  @action
  Future fetchDropdownProducts() async {
    final future = _fetchProductsDropdownUseCase.call(params: null);
    fetchProductsRes = ObservableFuture(future);

    future.then((value) {
      this.products = value;
    }).catchError((err) {
      throw err;
      // errorStore.errorMessage = err.toString();
    });
  }

  @action
  Future fetchDropdownContainers() async {
    final future = _fetchContainersDropdownUseCase.call(params: null);
    fetchContainersRes = ObservableFuture(future);

    future.then((value) {
      this.containers = value;
      for (var i in this.containers) {
        this.containerList.add(i.name);
      }
      print('isi container' + this.containers.length.toString());
    }).catchError((err) {
      throw err;
    });
  }

  @action
  Future fetchPackingData() async {
    final future = _fetchPackingUseCase.call(params: null);
    fetchContainersRes = ObservableFuture(future);

    future.then((value) {
      this.packings = value;
    }).catchError((err) {
      throw err;
    });
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class ProductReceiptData {
  String receivingNumber;
  String product;
  int expectedQc;
  int acceptedQc;
  String notes;

  ProductReceiptData({
    required this.receivingNumber,
    required this.product,
    required this.expectedQc,
    required this.acceptedQc,
    required this.notes,
  });

  String toJson() => json.encode(toMap());

  factory ProductReceiptData.fromJson(String source) =>
      ProductReceiptData.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receivingNumber': receivingNumber,
      'product': product,
      'expectedQc': expectedQc,
      'acceptedQc': acceptedQc,
      'notes': notes,
    };
  }

  factory ProductReceiptData.fromMap(Map<String, dynamic> map) {
    return ProductReceiptData(
      receivingNumber: map['receivingNumber'] as String,
      product: map['product'] as String,
      expectedQc: map['expectedQc'] as int,
      acceptedQc: map['acceptedQc'] as int,
      notes: map['notes'] as String,
    );
  }
}

class ContainerDropdownData {
  final String id;
  final String name;

  ContainerDropdownData({required this.id, required this.name});

  ContainerDropdownData copyWith({
    String? id,
    String? name,
  }) {
    return ContainerDropdownData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ContainerDropdownData.fromMap(Map<String, dynamic> map) {
    return ContainerDropdownData(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerDropdownData.fromJson(String source) =>
      ContainerDropdownData.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

enum DropdownListType { products, receivingNumber, containerList }
