import 'dart:async';

import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt_response.dart';
import 'package:boilerplate/domain/entity/receipt/packing_response.dart';
import 'package:boilerplate/presentation/receipt/add_receipt/store/add_goods_receipt_store.dart';

abstract class GoodsReceiptRepository {
  Future<GoodsReceiptData> getGoodsReceipt();

  Future<List<String>> getProducts();

  Future<List<GoodsReceipt>> findPostById(int id);

  Future<List<ContainerDropdownData>> getContainers();

  Future<List<PackingContent>> getPackingContent();

  Future<int> insert(GoodsReceipt post);

  Future<int> update(GoodsReceipt post);

  Future<int> delete(GoodsReceipt post);
}
