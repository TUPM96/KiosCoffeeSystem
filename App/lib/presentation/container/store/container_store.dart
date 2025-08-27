// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/container/container_detail.dart';
import 'package:boilerplate/domain/usecase/container/get_container_detail_usecase.dart';
import 'package:boilerplate/domain/usecase/container/get_container_usecase.dart';
import 'package:boilerplate/domain/usecase/container/get_upcoming_container_usecase.dart';
import 'package:boilerplate/presentation/receipt/store/goods_receipt_store.dart';
import 'package:boilerplate/utils/conversion/conversion.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';

part 'container_store.g.dart';

class ContainerStore = _ContainerStore with _$ContainerStore;

abstract class _ContainerStore with Store {
  _ContainerStore(
    this._getContainerUseCase,
    this._getContainerDetailUseCase,
    this._getUpcomingContainerUseCase,
    this.errorStore,
  ) {
    _setupDisposers();
  }
  // //repo instance
  // final ContainerRepository _repository;

  // query.length >= 2

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  _setupDisposers() {
    _disposers = [
      reaction((_) => this.detailQuery, (value) {
        if (value.length >= 2) {
          _searching = true;
        }
      })
    ];
  }

  //use cases
  final GetContainerUseCase _getContainerUseCase;

  final GetContainerDetailUseCase _getContainerDetailUseCase;

  final GetUpcomingContainerUseCase _getUpcomingContainerUseCase;

  //store for handling errors
  final ErrorStore errorStore;

  //store variables
  @observable
  ContainerListData? containerDataList;

  @observable
  List<ContainerDataUiModel?> containerDataUiModel = <ContainerDataUiModel>[];

  @observable
  ContainerDetailModel? containerDetailModel;

  @observable
  List<ContainerDataUiModel?> filteredContainerDataUiModel =
      <ContainerDataUiModel>[];

  @observable
  ContainerDetailModel? filteredContainerDetailModel;

  @observable
  List<PackingReceiveModel?> containerProducts = [];

  static ObservableFuture<ContainerListData?> emptyContainerResponse =
      ObservableFuture.value(null);

  @observable
  List<ContainerDataUiModel?> upcomingContainers = [];

  static ObservableFuture<ContainerListData?> emptyUpcomingContainerResponse =
      ObservableFuture.value(null);

  //searching
  @observable
  String detailQuery = '';

  @observable
  ObservableFuture<dynamic> fetchContainerFuture =
      ObservableFuture<ContainerListData?>(emptyContainerResponse);

  @observable
  ObservableFuture<dynamic> fetchUpcomingContainerFuture =
      ObservableFuture<ContainerListData?>(emptyUpcomingContainerResponse);

  @computed
  bool get loading => fetchContainerFuture.status == FutureStatus.pending;

  bool get searching => _searching;

  @observable
  bool _searching = false;

  @computed
  bool get upcomingContainerLoading =>
      fetchUpcomingContainerFuture.status == FutureStatus.pending;

  //actions
  void setIsSearching() {
    this._searching = !searching;
  }
  

  Future getContainerList() async {
    final future = _getContainerUseCase.call(params: null);
    fetchContainerFuture = ObservableFuture(future);

    future.then((containerDataList) {
      this.containerDataList = containerDataList;
      this.containerDataUiModel = containerDataList.content
          .where((element) =>
              element.history!.status == 'in_indonesia' ||
              element.history!.status == 'by_the_courier' ||
              element.history!.status == 'received')
          .map((e) {
        return ContainerDataUiModel(
          id: e.id,
          containerNumber: e.history!.packing!.containerNoInternal,
          items: e.product!.length,
          quantity: e.history!.packing!.history[0].receivedQc,
          dateTime: formatDateToString(e.createdAt),
        );
      }).toList();
    }).catchError((err) {
      if (err.runtimeType == DioException) {
        errorStore.errorMessage = DioErrorUtil.handleError(err);
      } else if (err.runtimeType == TypeError) {
        errorStore.errorMessage = err.toString();
      }
      errorStore.errorMessage = err.toString();
    }).whenComplete(
      () => print(
        'on store' + this.containerDataUiModel.length.toString(),
      ),
    );
  }

  Future getUpcomingContainer() async {
    final future = _getUpcomingContainerUseCase.call(params: null);
    fetchUpcomingContainerFuture = ObservableFuture(future);

    future.then((upcomingContainer) {
      upcomingContainer.content.forEach((element) {
        print(element.toJson().toString());
      });
      var mappedContainers = upcomingContainer.content.map((e) {
        var count = 0;
        e.product!.forEach((e) => count += e.qc);

        return ContainerDataUiModel(
          id: e.id,
          containerNumber: e.receivingNumber,
          items: e.product!.length,
          quantity: count,
          dateTime: formatDateToString(DateTime.now()),
        );
      }).toList();

      this.upcomingContainers = [
        ...{...mappedContainers}
      ];
    }).catchError((err) {
      if (err.runtimeType == DioException) {
        errorStore.errorMessage = DioErrorUtil.handleError(err);
      } else if (err.runtimeType == TypeError) {
        errorStore.errorMessage = err.toString();
      }
      errorStore.errorMessage = err.toString();
    }).whenComplete(
      () => print(
        'on store' + this.upcomingContainers.length.toString(),
      ),
    );
  }

  Future getContainerDetail(String id) async {
    final future = _getContainerDetailUseCase.call(params: id);
    fetchContainerFuture = ObservableFuture(future);

    future.then((containerDetail) {
      this.containerDetailModel = containerDetail;
      this.containerProducts = containerDetail.data.product
          .map(
            (e) => PackingReceiveModel(
                containerNoInternal: '',
                createdAt: formatDateToString(containerDetail.data.createdAt),
                markingNumber:
                    '${containerDetail.data.markingPrefix.name}:${containerDetail.data.markingNumber}',
                notes: '',
                product: e.name,
                receiveNote: containerDetail.data.receivingNumber,
                quantity: e.qc),
          )
          .toList();
    }).catchError((err) {
      print(err);
      errorStore.errorMessage = DioErrorUtil.handleError(err);
    });
  }

  //searching methods:-----------------------------------------------------------
  Future searchContainerDetail(String query) async {
    var data = this.containerDetailModel!.data;
    this.filteredContainerDetailModel = this.containerDetailModel!.copyWith(
          data: data.copyWith(
            product: data.product
                .where(
                  (element) =>
                      element.name.toLowerCase().contains(query) ||
                      element.status.toLowerCase().contains(query) ||
                      element.productCategory.name
                          .toLowerCase()
                          .contains(query) ||
                      element.productType.name.toLowerCase().contains(query),
                )
                .toList(),
          ),
        );
  }

  Future searchContainerData(String query) async {
    var data = this.containerDataUiModel;
    this.filteredContainerDataUiModel = data
        .where((element) =>
            element!.containerNumber!.contains(query) ||
            element.id!.contains(query))
        .toList();
  }

  void resetVariables() {
    this._searching = false;
    this.detailQuery = '';
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class ContainerDataUiModel extends Equatable {
  String? containerNumber;
  String? id;
  int? items;
  int? quantity;
  String? dateTime;

  ContainerDataUiModel(
      {required this.id,
      required this.containerNumber,
      required this.items,
      required this.quantity,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'containerNumber': containerNumber,
      'items': items,
      'quantity': quantity,
      'dateTime': dateTime,
    };
  }

  factory ContainerDataUiModel.fromMap(Map<String, dynamic> map) {
    return ContainerDataUiModel(
      id: map['id'],
      containerNumber: map['containerNumber'] as String,
      items: map['items'] as int,
      quantity: map['quantity'] as int,
      dateTime: map['dateTime'] as String,
    );
  }

  @override
  List<Object?> get props => [id];
}
