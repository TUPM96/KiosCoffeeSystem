// To parse this JSON data, do
//
//     final packingResponse = packingResponseFromJson(jsonString);

import 'dart:convert';

PackingResponse packingResponseFromJson(String str) =>
    PackingResponse.fromJson(json.decode(str));

String packingResponseToJson(PackingResponse data) =>
    json.encode(data.toJson());

class PackingResponse {
  String message;
  int status;
  Data data;

  PackingResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory PackingResponse.fromJson(Map<String, dynamic> json) =>
      PackingResponse(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<PackingContent> content;
  Pagination pagination;

  Data({
    required this.content,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<PackingContent>.from(
            json["content"].map((x) => PackingContent.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class PackingContent {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String containerNoConsortiom;
  String containerNoInternal;
  DateTime estimationDateCn;
  DateTime estimationDateId;
  dynamic dateCn;
  dynamic dateId;
  dynamic attach;
  List<PackingDetail> packingDetail;
  List<dynamic> media;

  PackingContent({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.containerNoConsortiom,
    required this.containerNoInternal,
    required this.estimationDateCn,
    required this.estimationDateId,
    required this.dateCn,
    required this.dateId,
    required this.attach,
    required this.packingDetail,
    required this.media,
  });

  factory PackingContent.fromJson(Map<String, dynamic> json) => PackingContent(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        containerNoConsortiom: json["container_no_consortiom"] ?? '',
        containerNoInternal: json["container_no_internal"],
        estimationDateCn: DateTime.parse(json["estimation_date_cn"]),
        estimationDateId: DateTime.parse(json["estimation_date_id"]),
        dateCn: json["date_cn"],
        dateId: json["date_id"],
        attach: json["attach"],
        packingDetail: List<PackingDetail>.from(
            json["packing_detail"].map((x) => PackingDetail.fromJson(x))),
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "container_no_consortiom": containerNoConsortiom,
        "container_no_internal": containerNoInternal,
        "estimation_date_cn":
            "${estimationDateCn.year.toString().padLeft(4, '0')}-${estimationDateCn.month.toString().padLeft(2, '0')}-${estimationDateCn.day.toString().padLeft(2, '0')}",
        "estimation_date_id":
            "${estimationDateId.year.toString().padLeft(4, '0')}-${estimationDateId.month.toString().padLeft(2, '0')}-${estimationDateId.day.toString().padLeft(2, '0')}",
        "date_cn": dateCn,
        "date_id": dateId,
        "attach": attach,
        "packing_detail":
            List<dynamic>.from(packingDetail.map((x) => x.toJson())),
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}

class PackingDetail {
  String id;
  String packingId;
  String receiveId;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;

  PackingDetail({
    required this.id,
    required this.packingId,
    required this.receiveId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory PackingDetail.fromJson(Map<String, dynamic> json) => PackingDetail(
        id: json["id"],
        packingId: json["packing_id"],
        receiveId: json["receive_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "packing_id": packingId,
        "receive_id": receiveId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
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
