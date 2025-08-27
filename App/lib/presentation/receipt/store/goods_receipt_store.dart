import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt_response.dart';
import 'package:boilerplate/utils/conversion/conversion.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecase/receipt/get_receipt_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'goods_receipt_store.g.dart';

class GoodsReceiptStore = _GoodsReceiptStore with _$GoodsReceiptStore;

abstract class _GoodsReceiptStore with Store {
  //constructor:---------------------------------------------------------------
  _GoodsReceiptStore(this._getGoodsReceiptUseCase, this.errorStore) {
    _setupDisposers();
  }

  // use cases:-----------------------------------------------------------------
  final GetGoodsReceiptUseCase _getGoodsReceiptUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() async {
    _disposers = [
      reaction(
        (_) => packingReceiveList,
        (p0) {
          packingReceiveList = p0;
        },
      ),
    ];
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<GoodsReceiptData?> emptyReceiptResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchPostsFuture =
      ObservableFuture<GoodsReceiptData?>(emptyReceiptResponse);

  @observable
  GoodsReceiptData? goodsReceiptData;

  @observable
  bool success = false;

  @observable
  List<PackingReceiveModel> packingReceiveList = [];

  @observable
  List<PackingReceiveModel> filteredPackingReceiveList = [];

  @observable
  DateTime startDate = DateTime.now();

  @observable
  DateTime endDate = DateTime.now();

  @observable
  String detailQuery = '';

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {
    final future = _getGoodsReceiptUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);

    future.then((goodsReceiptList) {
      this.goodsReceiptData = goodsReceiptList;
      this.packingReceiveList = this
          .goodsReceiptData!
          .content
          .map(
            (e) => PackingReceiveModel(
                markingNumber: e.markingNumber,
                notes: e.notes,
                containerNoInternal: e.containerNoInternal,
                createdAt: formatDateToString(e.createdAt),
                product: e.product,
                quantity: e.receivedQc,
                receiveNote: e.receivingNumber),
          )
          .toList();
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  removeData(int index) {
    this.packingReceiveList.removeAt(index);
  }

  Future searchProductData(String query) async {
    this.filteredPackingReceiveList = this
        .packingReceiveList
        .where(
          (element) =>
              element.markingNumber.contains(query) ||
              element.notes.contains(query) ||
              element.product.contains(query),
        )
        .toList();
  }

  Future filterByDate() async {
    await searchProductData(this.detailQuery).then((_) {
      this.filteredPackingReceiveList =
          this.filteredPackingReceiveList.where((element) {
        return startDate.isBefore(
              formatStringToDateTime(element.createdAt),
            ) &&
            endDate.isAfter(
              formatStringToDateTime(element.createdAt),
            );
      }).toList();
    });
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class PackingReceiveModel {
  final String containerNoInternal;
  final String createdAt;
  final String product;
  final String receiveNote;
  final int quantity;
  final String markingNumber;
  final String notes;

  PackingReceiveModel(
      {required this.containerNoInternal,
      required this.createdAt,
      required this.markingNumber,
      required this.notes,
      required this.product,
      required this.receiveNote,
      required this.quantity});
}
