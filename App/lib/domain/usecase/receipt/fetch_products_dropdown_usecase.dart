import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class FetchProductsDropdownUsecase extends UseCase<List<String>, void> {
  final GoodsReceiptRepository _receiptRepository;

  FetchProductsDropdownUsecase(this._receiptRepository);

  @override
  Future<List<String>> call({required void params}) async {
    return _receiptRepository.getProducts();
  }
}
