// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

ContainerListResponse containerListResponseFromJson(String str) =>
    ContainerListResponse.fromJson(json.decode(str));

String containerListResponseToJson(ContainerListResponse data) =>
    json.encode(data.toJson());

class ContainerListResponse {
  String message;
  int status;
  ContainerListData data;

  ContainerListResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ContainerListResponse.fromJson(Map<String, dynamic> json) =>
      ContainerListResponse(
        message: json["message"],
        status: json["status"],
        data: ContainerListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class ContainerListData {
  List<ContainerListContent> content;
  Pagination pagination;

  ContainerListData({
    required this.content,
    required this.pagination,
  });

  factory ContainerListData.fromJson(Map<String, dynamic> json) =>
      ContainerListData(
        content: List<ContainerListContent>.from(
            json["content"].map((x) => ContainerListContent.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class HistoryElement {
  String id;
  String packingId;
  String receiveId;
  String productId;
  int receivedQc;
  String? notes;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  ContainerListContent receive;

  HistoryElement({
    required this.id,
    required this.packingId,
    required this.receiveId,
    required this.productId,
    required this.receivedQc,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.receive,
  });

  factory HistoryElement.fromJson(Map<String, dynamic> json) => HistoryElement(
        id: json["id"],
        packingId: json["packing_id"],
        receiveId: json["receive_id"],
        productId: json["product_id"],
        receivedQc: json["received_qc"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        receive: ContainerListContent.fromJson(json["receive"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "packing_id": packingId,
        "receive_id": receiveId,
        "product_id": productId,
        "received_qc": receivedQc,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "receive": receive.toJson(),
      };
}

class Packing {
  String id;
  DateTime stuffingDate;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String packingListId;
  String containerNoConsortiom;
  String containerNoInternal;
  DateTime estimationDateCn;
  DateTime estimationDateId;
  dynamic dateCn;
  dynamic dateId;
  dynamic attach;
  List<HistoryElement> history;
  List<dynamic> media;

  Packing({
    required this.id,
    required this.stuffingDate,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.packingListId,
    required this.containerNoConsortiom,
    required this.containerNoInternal,
    required this.estimationDateCn,
    required this.estimationDateId,
    required this.dateCn,
    required this.dateId,
    required this.attach,
    required this.history,
    required this.media,
  });

  factory Packing.fromJson(Map<String, dynamic> json) => Packing(
        id: json["id"],
        stuffingDate: DateTime.parse(json["stuffing_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        packingListId: json["packing_list_id"],
        containerNoConsortiom: json["container_no_consortiom"],
        containerNoInternal: json["container_no_internal"],
        estimationDateCn: DateTime.parse(json["estimation_date_cn"]),
        estimationDateId: DateTime.parse(json["estimation_date_id"]),
        dateCn: json["date_cn"],
        dateId: json["date_id"],
        attach: json["attach"],
        history: List<HistoryElement>.from(
            json["history"].map((x) => HistoryElement.fromJson(x))),
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stuffing_date": stuffingDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "packing_list_id": packingListId,
        "container_no_consortiom": containerNoConsortiom,
        "container_no_internal": containerNoInternal,
        "estimation_date_cn":
            "${estimationDateCn.year.toString().padLeft(4, '0')}-${estimationDateCn.month.toString().padLeft(2, '0')}-${estimationDateCn.day.toString().padLeft(2, '0')}",
        "estimation_date_id":
            "${estimationDateId.year.toString().padLeft(4, '0')}-${estimationDateId.month.toString().padLeft(2, '0')}-${estimationDateId.day.toString().padLeft(2, '0')}",
        "date_cn": dateCn,
        "date_id": dateId,
        "attach": attach,
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}

class ContentHistory {
  String id;
  String receiveId;
  String? packingId;
  String status;
  List<Activity> activities;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String? packingStatus;
  Packing? packing;

  ContentHistory({
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

  factory ContentHistory.fromJson(Map<String, dynamic> json) => ContentHistory(
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
        packing:
            json["packing"] == null ? null : Packing.fromJson(json["packing"]),
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
        "packing": packing?.toJson(),
      };
}

class ContainerListContent {
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
  MarkingNumber markingNumber;
  DeliveryOrder deliveryOrder;
  MarkingPrefix receivingPrefix;
  MarkingPrefix markingPrefix;
  List<Product>? product;
  ContentHistory? history;

  ContainerListContent({
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
    this.product,
    this.history,
  });

  factory ContainerListContent.fromJson(Map<String, dynamic> json) =>
      ContainerListContent(
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
        markingNumber: markingNumberValues.map[json["marking_number"]]!,
        deliveryOrder: deliveryOrderValues.map[json["delivery_order"]]!,
        receivingPrefix: MarkingPrefix.fromJson(json["receiving_prefix"]),
        markingPrefix: MarkingPrefix.fromJson(json["marking_prefix"]),
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
        history: json["history"] == null
            ? null
            : ContentHistory.fromJson(json["history"]),
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
        "marking_number": markingNumberValues.reverse[markingNumber],
        "delivery_order": deliveryOrderValues.reverse[deliveryOrder],
        "receiving_prefix": receivingPrefix.toJson(),
        "marking_prefix": markingPrefix.toJson(),
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "history": history?.toJson(),
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

enum DeliveryOrder { EMPTY, MANTAP, TEST }

final deliveryOrderValues = EnumValues({
  "-": DeliveryOrder.EMPTY,
  "Mantap": DeliveryOrder.MANTAP,
  "test": DeliveryOrder.TEST
});

class InvoiceDetail {
  String id;
  String receiveId;
  String invoiceId;
  int totalPrice;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String productId;
  int overweightPrice;
  Invoice invoice;
  Product product;

  InvoiceDetail({
    required this.id,
    required this.receiveId,
    required this.invoiceId,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.productId,
    required this.overweightPrice,
    required this.invoice,
    required this.product,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        id: json["id"],
        receiveId: json["receive_id"],
        invoiceId: json["invoice_id"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        productId: json["product_id"],
        overweightPrice: json["overweight_price"],
        invoice: Invoice.fromJson(json["invoice"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receive_id": receiveId,
        "invoice_id": invoiceId,
        "total_price": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "product_id": productId,
        "overweight_price": overweightPrice,
        "invoice": invoice.toJson(),
        "product": product.toJson(),
      };
}

class Invoice {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String number;
  String markingId;
  String createdBy;
  String updatedBy;
  MarkingNumber markingNumber;
  String status;
  String chartOfAccountId;
  List<MarkingPrefix> account;

  Invoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.number,
    required this.markingId,
    required this.createdBy,
    required this.updatedBy,
    required this.markingNumber,
    required this.status,
    required this.chartOfAccountId,
    required this.account,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        number: json["number"],
        markingId: json["marking_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        markingNumber: markingNumberValues.map[json["marking_number"]]!,
        status: json["status"],
        chartOfAccountId: json["chart_of_account_id"],
        account: List<MarkingPrefix>.from(
            json["account"].map((x) => MarkingPrefix.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "number": number,
        "marking_id": markingId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "marking_number": markingNumberValues.reverse[markingNumber],
        "status": status,
        "chart_of_account_id": chartOfAccountId,
        "account": List<dynamic>.from(account.map((x) => x.toJson())),
      };
}

class MarkingPrefix {
  String id;
  String name;
  String? accountNumber;
  bool? isDefault;
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
    this.accountNumber,
    this.isDefault,
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
        accountNumber: json["account_number"],
        isDefault: json["is_default"],
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
        "account_number": accountNumber,
        "is_default": isDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "via": via,
        "price_min": priceMin,
        "product_category_id": productCategoryId,
      };
}

enum MarkingNumber { QTINE, THE_55_CST, THE_55_ICA }

final markingNumberValues = EnumValues({
  "QTINE": MarkingNumber.QTINE,
  "55/CST": MarkingNumber.THE_55_CST,
  "55/ICA": MarkingNumber.THE_55_ICA
});

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
  MarkingPrefix? productCategory;
  MarkingPrefix? productType;

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
    this.productCategory,
    this.productType,
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
        productCategory: json["product_category"] == null
            ? null
            : MarkingPrefix.fromJson(json["product_category"]),
        productType: json["product_type"] == null
            ? null
            : MarkingPrefix.fromJson(json["product_type"]),
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
        "product_category": productCategory?.toJson(),
        "product_type": productType?.toJson(),
      };
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
