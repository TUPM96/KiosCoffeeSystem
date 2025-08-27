// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

ContainerDetailModel containerDetailModelFromJson(String str) =>
    ContainerDetailModel.fromJson(json.decode(str));

String containerDetailModelToJson(ContainerDetailModel data) =>
    json.encode(data.toJson());

class ContainerDetailModel {
  ContainerDetailData data;

  ContainerDetailModel({
    required this.data,
  });

  factory ContainerDetailModel.fromJson(Map<String, dynamic> json) =>
      ContainerDetailModel(
        data: ContainerDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };

  ContainerDetailModel copyWith({
    ContainerDetailData? data,
  }) {
    return ContainerDetailModel(
      data: data ?? this.data,
    );
  }
}

class ContainerDetailData {
  String id;
  DateTime dateCn;
  DateTime dateId;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String receivingPrefixId;
  String markingPrefixId;
  String receivingNumber;
  String markingNumber;
  String deliveryOrder;
  MarkingPrefix receivingPrefix;
  MarkingPrefix markingPrefix;
  List<Product> product;
  History history;
  dynamic invoiceDetail;

  ContainerDetailData({
    required this.id,
    required this.dateCn,
    required this.dateId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.receivingPrefixId,
    required this.markingPrefixId,
    required this.receivingNumber,
    required this.markingNumber,
    required this.deliveryOrder,
    required this.receivingPrefix,
    required this.markingPrefix,
    required this.product,
    required this.history,
    required this.invoiceDetail,
  });

  factory ContainerDetailData.fromJson(Map<String, dynamic> json) =>
      ContainerDetailData(
        id: json["id"],
        dateCn: DateTime.parse(json["date_cn"]),
        dateId: DateTime.parse(json["date_id"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        receivingPrefixId: json["receiving_prefix_id"],
        markingPrefixId: json["marking_prefix_id"],
        receivingNumber: json["receiving_number"],
        markingNumber: json["marking_number"],
        deliveryOrder: json["delivery_order"],
        receivingPrefix: MarkingPrefix.fromJson(json["receiving_prefix"]),
        markingPrefix: MarkingPrefix.fromJson(json["marking_prefix"]),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        history: History.fromJson(json["history"]),
        invoiceDetail: json["invoice_detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_cn": dateCn.toIso8601String(),
        "date_id": dateId.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "receiving_prefix_id": receivingPrefixId,
        "marking_prefix_id": markingPrefixId,
        "receiving_number": receivingNumber,
        "marking_number": markingNumber,
        "delivery_order": deliveryOrder,
        "receiving_prefix": receivingPrefix.toJson(),
        "marking_prefix": markingPrefix.toJson(),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "history": history.toJson(),
        "invoice_detail": invoiceDetail,
      };

  ContainerDetailData copyWith({
    String? id,
    DateTime? dateCn,
    DateTime? dateId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? receivingPrefixId,
    String? markingPrefixId,
    String? receivingNumber,
    String? markingNumber,
    String? deliveryOrder,
    MarkingPrefix? receivingPrefix,
    MarkingPrefix? markingPrefix,
    List<Product>? product,
    History? history,
    dynamic invoiceDetail,
  }) {
    return ContainerDetailData(
      id: id ?? this.id,
      dateCn: dateCn ?? this.dateCn,
      dateId: dateId ?? this.dateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      receivingPrefixId: receivingPrefixId ?? this.receivingPrefixId,
      markingPrefixId: markingPrefixId ?? this.markingPrefixId,
      receivingNumber: receivingNumber ?? this.receivingNumber,
      markingNumber: markingNumber ?? this.markingNumber,
      deliveryOrder: deliveryOrder ?? this.deliveryOrder,
      receivingPrefix: receivingPrefix ?? this.receivingPrefix,
      markingPrefix: markingPrefix ?? this.markingPrefix,
      product: product ?? this.product,
      history: history ?? this.history,
      invoiceDetail: invoiceDetail ?? this.invoiceDetail,
    );
  }
}

class History {
  String id;
  String receiveId;
  dynamic packingId;
  String status;
  List<Activity> activities;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  dynamic packingStatus;
  dynamic packing;

  History({
    required this.id,
    required this.receiveId,
    required this.packingId,
    required this.status,
    required this.activities,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.packingStatus,
    required this.packing,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        receiveId: json["receive_id"],
        packingId: json["packing_id"],
        status: json["status"],
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        packingStatus: json["packing_status"],
        packing: json["packing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receive_id": receiveId,
        "packing_id": packingId,
        "status": status,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "packing_status": packingStatus,
        "packing": packing,
      };
}

class Activity {
  DateTime date;
  String label;
  String status;

  Activity({
    required this.date,
    required this.label,
    required this.status,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        date: DateTime.parse(json["date"]),
        label: json["label"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "label": label,
        "status": status,
      };
}

class MarkingPrefix {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String? via;
  int? priceMin;
  String? productCategoryId;

  MarkingPrefix({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    this.via,
    this.priceMin,
    this.productCategoryId,
  });

  factory MarkingPrefix.fromJson(Map<String, dynamic> json) => MarkingPrefix(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        via: json["via"],
        priceMin: json["price_min"],
        productCategoryId: json["product_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "via": via,
        "price_min": priceMin,
        "product_category_id": productCategoryId,
      };
}

class Product {
  String id;
  String name;
  String receiveId;
  String productCategoryId;
  String productTypeId;
  int qc;
  int length;
  int width;
  int height;
  int volume;
  int weight;
  int overweight;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  MarkingPrefix productCategory;
  MarkingPrefix productType;

  Product({
    required this.id,
    required this.name,
    required this.receiveId,
    required this.productCategoryId,
    required this.productTypeId,
    required this.qc,
    required this.length,
    required this.width,
    required this.height,
    required this.volume,
    required this.weight,
    required this.overweight,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.productCategory,
    required this.productType,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        receiveId: json["receive_id"],
        productCategoryId: json["product_category_id"],
        productTypeId: json["product_type_id"],
        qc: json["qc"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        volume: json["volume"],
        weight: json["weight"],
        overweight: json["overweight"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        productCategory: MarkingPrefix.fromJson(json["product_category"]),
        productType: MarkingPrefix.fromJson(json["product_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "receive_id": receiveId,
        "product_category_id": productCategoryId,
        "product_type_id": productTypeId,
        "qc": qc,
        "length": length,
        "width": width,
        "height": height,
        "volume": volume,
        "weight": weight,
        "overweight": overweight,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "product_category": productCategory.toJson(),
        "product_type": productType.toJson(),
      };
}
