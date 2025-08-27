// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/domain/entity/upcoming/upcoming_container.dart';

class UpcomingContainerList {
  List<UpcomingContainer>? upcomingContainers;

  UpcomingContainerList({
    this.upcomingContainers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'upcomingContainers': upcomingContainers!.map((x) => x.toMap()).toList(),
    };
  }

  factory UpcomingContainerList.fromMap(Map<String, dynamic> map) {
    return UpcomingContainerList(
      upcomingContainers: map['upcomingContainers'] != null
          ? List<UpcomingContainer>.from(
              (map['upcomingContainers'] as List<int>).map<UpcomingContainer?>(
                (x) => UpcomingContainer.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingContainerList.fromJson(String source) =>
      UpcomingContainerList.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
