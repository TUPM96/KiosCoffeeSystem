// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContainerStore on _ContainerStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ContainerStore.loading'))
      .value;
  Computed<bool>? _$upcomingContainerLoadingComputed;

  @override
  bool get upcomingContainerLoading => (_$upcomingContainerLoadingComputed ??=
          Computed<bool>(() => super.upcomingContainerLoading,
              name: '_ContainerStore.upcomingContainerLoading'))
      .value;

  late final _$containerDataListAtom =
      Atom(name: '_ContainerStore.containerDataList', context: context);

  @override
  ContainerListData? get containerDataList {
    _$containerDataListAtom.reportRead();
    return super.containerDataList;
  }

  @override
  set containerDataList(ContainerListData? value) {
    _$containerDataListAtom.reportWrite(value, super.containerDataList, () {
      super.containerDataList = value;
    });
  }

  late final _$containerDataUiModelAtom =
      Atom(name: '_ContainerStore.containerDataUiModel', context: context);

  @override
  List<ContainerDataUiModel?> get containerDataUiModel {
    _$containerDataUiModelAtom.reportRead();
    return super.containerDataUiModel;
  }

  @override
  set containerDataUiModel(List<ContainerDataUiModel?> value) {
    _$containerDataUiModelAtom.reportWrite(value, super.containerDataUiModel,
        () {
      super.containerDataUiModel = value;
    });
  }

  late final _$containerDetailModelAtom =
      Atom(name: '_ContainerStore.containerDetailModel', context: context);

  @override
  ContainerDetailModel? get containerDetailModel {
    _$containerDetailModelAtom.reportRead();
    return super.containerDetailModel;
  }

  @override
  set containerDetailModel(ContainerDetailModel? value) {
    _$containerDetailModelAtom.reportWrite(value, super.containerDetailModel,
        () {
      super.containerDetailModel = value;
    });
  }

  late final _$filteredContainerDataUiModelAtom = Atom(
      name: '_ContainerStore.filteredContainerDataUiModel', context: context);

  @override
  List<ContainerDataUiModel?> get filteredContainerDataUiModel {
    _$filteredContainerDataUiModelAtom.reportRead();
    return super.filteredContainerDataUiModel;
  }

  @override
  set filteredContainerDataUiModel(List<ContainerDataUiModel?> value) {
    _$filteredContainerDataUiModelAtom
        .reportWrite(value, super.filteredContainerDataUiModel, () {
      super.filteredContainerDataUiModel = value;
    });
  }

  late final _$filteredContainerDetailModelAtom = Atom(
      name: '_ContainerStore.filteredContainerDetailModel', context: context);

  @override
  ContainerDetailModel? get filteredContainerDetailModel {
    _$filteredContainerDetailModelAtom.reportRead();
    return super.filteredContainerDetailModel;
  }

  @override
  set filteredContainerDetailModel(ContainerDetailModel? value) {
    _$filteredContainerDetailModelAtom
        .reportWrite(value, super.filteredContainerDetailModel, () {
      super.filteredContainerDetailModel = value;
    });
  }

  late final _$containerProductsAtom =
      Atom(name: '_ContainerStore.containerProducts', context: context);

  @override
  List<PackingReceiveModel?> get containerProducts {
    _$containerProductsAtom.reportRead();
    return super.containerProducts;
  }

  @override
  set containerProducts(List<PackingReceiveModel?> value) {
    _$containerProductsAtom.reportWrite(value, super.containerProducts, () {
      super.containerProducts = value;
    });
  }

  late final _$upcomingContainersAtom =
      Atom(name: '_ContainerStore.upcomingContainers', context: context);

  @override
  List<ContainerDataUiModel?> get upcomingContainers {
    _$upcomingContainersAtom.reportRead();
    return super.upcomingContainers;
  }

  @override
  set upcomingContainers(List<ContainerDataUiModel?> value) {
    _$upcomingContainersAtom.reportWrite(value, super.upcomingContainers, () {
      super.upcomingContainers = value;
    });
  }

  late final _$detailQueryAtom =
      Atom(name: '_ContainerStore.detailQuery', context: context);

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

  late final _$fetchContainerFutureAtom =
      Atom(name: '_ContainerStore.fetchContainerFuture', context: context);

  @override
  ObservableFuture<dynamic> get fetchContainerFuture {
    _$fetchContainerFutureAtom.reportRead();
    return super.fetchContainerFuture;
  }

  @override
  set fetchContainerFuture(ObservableFuture<dynamic> value) {
    _$fetchContainerFutureAtom.reportWrite(value, super.fetchContainerFuture,
        () {
      super.fetchContainerFuture = value;
    });
  }

  late final _$fetchUpcomingContainerFutureAtom = Atom(
      name: '_ContainerStore.fetchUpcomingContainerFuture', context: context);

  @override
  ObservableFuture<dynamic> get fetchUpcomingContainerFuture {
    _$fetchUpcomingContainerFutureAtom.reportRead();
    return super.fetchUpcomingContainerFuture;
  }

  @override
  set fetchUpcomingContainerFuture(ObservableFuture<dynamic> value) {
    _$fetchUpcomingContainerFutureAtom
        .reportWrite(value, super.fetchUpcomingContainerFuture, () {
      super.fetchUpcomingContainerFuture = value;
    });
  }

  late final _$_searchingAtom =
      Atom(name: '_ContainerStore._searching', context: context);

  @override
  bool get _searching {
    _$_searchingAtom.reportRead();
    return super._searching;
  }

  @override
  set _searching(bool value) {
    _$_searchingAtom.reportWrite(value, super._searching, () {
      super._searching = value;
    });
  }

  @override
  String toString() {
    return '''
containerDataList: ${containerDataList},
containerDataUiModel: ${containerDataUiModel},
containerDetailModel: ${containerDetailModel},
filteredContainerDataUiModel: ${filteredContainerDataUiModel},
filteredContainerDetailModel: ${filteredContainerDetailModel},
containerProducts: ${containerProducts},
upcomingContainers: ${upcomingContainers},
detailQuery: ${detailQuery},
fetchContainerFuture: ${fetchContainerFuture},
fetchUpcomingContainerFuture: ${fetchUpcomingContainerFuture},
loading: ${loading},
upcomingContainerLoading: ${upcomingContainerLoading}
    ''';
  }
}
