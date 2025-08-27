// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';

GoodsReceiptResponse goodsReceiptResponseFromJson(String str) =>
    GoodsReceiptResponse.fromJson(json.decode(str));

String goodsReceiptResponseToJson(GoodsReceiptResponse data) =>
    json.encode(data.toJson());

class GoodsReceiptResponse {
  String message;
  int status;
  GoodsReceiptData goodsData;

  GoodsReceiptResponse({
    required this.message,
    required this.status,
    required this.goodsData,
  });

  factory GoodsReceiptResponse.fromJson(Map<String, dynamic> json) =>
      GoodsReceiptResponse(
        message: json["message"],
        status: json["status"],
        goodsData: GoodsReceiptData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": goodsData.toJson(),
      };
}

class GoodsReceiptData {
  List<GoodsReceipt> content;
  Pagination pagination;

  GoodsReceiptData({
    required this.content,
    required this.pagination,
  });

  factory GoodsReceiptData.fromJson(Map<String, dynamic> json) =>
      GoodsReceiptData(
        content: List<GoodsReceipt>.from(
          json["content"].map(
            (x) => GoodsReceipt.fromJson(x),
          ),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };

  GoodsReceiptData copyWith({
    List<GoodsReceipt>? content,
    Pagination? pagination,
  }) {
    return GoodsReceiptData(
      content: content ?? this.content,
      pagination: pagination ?? this.pagination,
    );
  }
}

class Pagination {
  int total;
  int lastPage;
  int perPage;
  int currentPage;

  Pagination({
    required this.total,
    required this.lastPage,
    required this.perPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "last_page": lastPage,
        "per_page": perPage,
        "current_page": currentPage,
      };
}
