import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/packing_response.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class FetchPackingUseCase extends UseCase<List<PackingContent>, void> {
  final GoodsReceiptRepository _receiptRepository;

  FetchPackingUseCase(this._receiptRepository);

  @override
  Future<List<PackingContent>> call({required void params}) {
    return _receiptRepository.getPackingContent();
  }
}
