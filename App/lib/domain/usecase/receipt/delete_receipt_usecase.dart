import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class DeleteReceiptUseCase extends UseCase<int, GoodsReceipt> {
  final GoodsReceiptRepository _receiptRepository;

  DeleteReceiptUseCase(this._receiptRepository);

  @override
  Future<int> call({required params}) {
    return _receiptRepository.delete(params);
  }
}
