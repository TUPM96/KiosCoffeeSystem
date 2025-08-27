import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';

class FindReceiptByIdUseCase extends UseCase<List<GoodsReceipt>, int> {
  final GoodsReceiptRepository _receiptRepository;

  FindReceiptByIdUseCase(this._receiptRepository);

  @override
  Future<List<GoodsReceipt>> call({required int params}) {
    return _receiptRepository.findPostById(params);
  }
}
