import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt_response.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class GetGoodsReceiptUseCase extends UseCase<GoodsReceiptData, void> {
  final GoodsReceiptRepository _receiptRepository;

  GetGoodsReceiptUseCase(this._receiptRepository);

  @override
  Future<GoodsReceiptData> call({required params}) {
    return _receiptRepository.getGoodsReceipt();
  }
}
