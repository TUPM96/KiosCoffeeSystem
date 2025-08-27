import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContainerData {
  String? containerNumber;
  int? items;
  int? quantity;
  String? dateTime;

  ContainerData(
      {required this.containerNumber,
      required this.items,
      required this.quantity,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'containerNumber': containerNumber,
      'items': items,
      'quantity': quantity,
      'dateTime': dateTime,
    };
  }

  factory ContainerData.fromMap(Map<String, dynamic> map) {
    return ContainerData(
      containerNumber: map['containerNumber'] as String,
      items: map['items'] as int,
      quantity: map['quantity'] as int,
      dateTime: map['dateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerData.fromJson(String source) =>
      ContainerData.fromMap(json.decode(source) as Map<String, dynamic>);
}
