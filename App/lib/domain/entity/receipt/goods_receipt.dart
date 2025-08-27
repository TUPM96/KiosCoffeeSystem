// ignore_for_file: public_member_api_docs, sort_constructors_first
class GoodsReceipt {
  String containerNoConsortiom;
  String containerNoInternal;
  String product;
  int receivedQc;
  String notes;
  String markingNumber;
  DateTime createdAt;
  String receivingNumber;
  String id;

  GoodsReceipt({
    required this.containerNoConsortiom,
    required this.containerNoInternal,
    required this.product,
    required this.receivedQc,
    required this.notes,
    required this.markingNumber,
    required this.createdAt,
    required this.receivingNumber,
    required this.id,
  });

  factory GoodsReceipt.fromJson(Map<String, dynamic> json) => GoodsReceipt(
      notes: json["notes"] == null ? '' : json['notes'],
      markingNumber: json["marking_number"],
      containerNoConsortiom: json["container_no_consortiom"],
      containerNoInternal: json["container_no_internal"],
      product: json["product"],
      receivedQc: json["received_qc"],
      createdAt: DateTime.parse(json["created_at"]),
      receivingNumber: json['receiving_number'],
      id: '-1');

  Map<String, dynamic> toJson() => {
        "container_no_consortiom": containerNoConsortiom,
        "container_no_internal": containerNoInternal,
        "marking_number": markingNumber,
        'notes': notes,
        "product": product,
        "received_qc": receivedQc,
        "created_at": createdAt.toIso8601String(),
        'receiving_number': receivingNumber,
        "id": '0'
      };

  GoodsReceipt copyWith({
    String? containerNoConsortiom,
    String? containerNoInternal,
    String? receiveNote,
    String? product,
    String? markingNumber,
    String? notes,
    int? receivedQc,
    DateTime? createdAt,
    String? receivingNumber,
    String? id,
  }) {
    return GoodsReceipt(
      containerNoConsortiom:
          containerNoConsortiom ?? this.containerNoConsortiom,
      containerNoInternal: containerNoInternal ?? this.containerNoInternal,
      markingNumber: markingNumber ?? this.markingNumber,
      notes: notes ?? this.notes,
      product: product ?? this.product,
      receivedQc: receivedQc ?? this.receivedQc,
      receivingNumber: receivingNumber ?? this.receivingNumber,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }
}
