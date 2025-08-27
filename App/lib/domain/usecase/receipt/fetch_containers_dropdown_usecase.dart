import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';
import 'package:boilerplate/presentation/receipt/add_receipt/store/add_goods_receipt_store.dart';

class FetchContainersDropdownUseCase
    extends UseCase<List<ContainerDropdownData>, void> {
  final GoodsReceiptRepository _receiptRepository;

  FetchContainersDropdownUseCase(
      {required GoodsReceiptRepository receiptRepository})
      : _receiptRepository = receiptRepository;

  @override
  Future<List<ContainerDropdownData>> call({required params}) {
    return _receiptRepository.getContainers();
  }
}
