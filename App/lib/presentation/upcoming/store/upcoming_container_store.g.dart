// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_container_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpcomingContainerStore on _UpcomingContainerStore, Store {
  late final _$_isLoadingAtom =
      Atom(name: '_UpcomingContainerStore._isLoading', context: context);

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$upcomingContainerListAtom = Atom(
      name: '_UpcomingContainerStore.upcomingContainerList', context: context);

  @override
  UpcomingContainerList? get upcomingContainerList {
    _$upcomingContainerListAtom.reportRead();
    return super.upcomingContainerList;
  }

  @override
  set upcomingContainerList(UpcomingContainerList? value) {
    _$upcomingContainerListAtom.reportWrite(value, super.upcomingContainerList,
        () {
      super.upcomingContainerList = value;
    });
  }

  late final _$fetchContainerFutureAtom = Atom(
      name: '_UpcomingContainerStore.fetchContainerFuture', context: context);

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

  @override
  String toString() {
    return '''
upcomingContainerList: ${upcomingContainerList},
fetchContainerFuture: ${fetchContainerFuture}
    ''';
  }
}
