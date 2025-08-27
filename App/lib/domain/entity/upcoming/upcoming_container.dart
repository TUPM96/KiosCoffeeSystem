import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpcomingContainer {
  String? containerNumber;
  String? estimationTime;
  int? items;
  int? quantity;

  UpcomingContainer({
    required this.containerNumber,
    required this.estimationTime,
    required this.items,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'containerNumber': containerNumber,
      'estimationTime': estimationTime,
      'items': items,
      'quantity': quantity,
    };
  }

  factory UpcomingContainer.fromMap(Map<String, dynamic> map) {
    return UpcomingContainer(
      containerNumber: map['containerNumber'] != null
          ? map['containerNumber'] as String
          : null,
      estimationTime: map['estimationTime'] != null
          ? map['estimationTime'] as String
          : null,
      items: map['items'] != null ? map['items'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingContainer.fromJson(String source) =>
      UpcomingContainer.fromMap(json.decode(source) as Map<String, dynamic>);
}
