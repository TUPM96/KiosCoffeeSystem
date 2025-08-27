import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/upcoming/upcoming_container_list.dart';
import 'package:boilerplate/domain/usecase/container/get_upcoming_container_usecase.dart';
import 'package:mobx/mobx.dart';

part 'upcoming_container_store.g.dart';

class UpcomingContainerStore = _UpcomingContainerStore
    with _$UpcomingContainerStore;

abstract class _UpcomingContainerStore with Store {
  _UpcomingContainerStore(
      {required this.getUpcomingContainerUseCase, required this.errorStore});

  //use cases
  final GetUpcomingContainerUseCase getUpcomingContainerUseCase;

  final ErrorStore errorStore;

  //store variables
  @observable
  bool _isLoading = false;

  @observable
  UpcomingContainerList? upcomingContainerList;

  static ObservableFuture<UpcomingContainerList?> emptyContainerResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchContainerFuture =
      ObservableFuture<UpcomingContainerList?>(emptyContainerResponse);

  //getters
  bool get isLoading => _isLoading;

  // //general methods
  // Future fetchUpcomingContainer() async {
  //   final future = getUpcomingContainerUseCase.call(params: null);
  //   fetchContainerFuture = ObservableFuture(future);

  //   future.then((value) => this.upcomingContainerList = value).catchError(
  //     (err) {
  //       errorStore.errorMessage = DioErrorUtil.handleError(err);
  //     },
  //   );
  // }
}
