import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class UpdateReceiptUseCase extends UseCase<int, GoodsReceipt> {
  final GoodsReceiptRepository _receiptRepository;

  UpdateReceiptUseCase(this._receiptRepository);

  @override
  Future<int> call({required params}) {
    return _receiptRepository.update(params);
  }
}
