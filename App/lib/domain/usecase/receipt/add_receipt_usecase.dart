import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class AddGoodsReceiptUseCase extends UseCase<int, GoodsReceipt> {
  final GoodsReceiptRepository _receiptRepository;

  AddGoodsReceiptUseCase(this._receiptRepository);

  @override
  Future<int> call({required GoodsReceipt params}) async {
    return _receiptRepository.insert(params);
  }
}
