// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) =>
    UserInfoResponse.fromJson(json.decode(str));

String userInfoResponseToJson(UserInfoResponse data) =>
    json.encode(data.toJson());

class UserInfoResponse {
  String message;
  int status;
  UserInfo? data;

  UserInfoResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
          message: json["message"],
          status: json["status"],
          data: UserInfo.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class UserInfo {
  String id;
  String name;
  String phoneNumber;
  String address;
  String email;
  int userType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime createdBy;
  DateTime updatedBy;
  bool isBroker;
  dynamic isGroup;
  String accessToken;
  List<Role> roles;
  List<dynamic> userPriceList;

  UserInfo({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.userType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.isBroker,
    required this.isGroup,
    required this.accessToken,
    required this.roles,
    required this.userPriceList,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        email: json["email"],
        userType: json["user_type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: DateTime.parse(json["created_by"]),
        updatedBy: DateTime.parse(json["updated_by"]),
        isBroker: json["is_broker"],
        isGroup: json["is_group"],
        accessToken: json["access_token"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        userPriceList:
            List<dynamic>.from(json["user_price_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "email": email,
        "user_type": userType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy.toIso8601String(),
        "updated_by": updatedBy.toIso8601String(),
        "is_broker": isBroker,
        "is_group": isGroup,
        "access_token": accessToken,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "user_price_list": List<dynamic>.from(userPriceList.map((x) => x)),
      };

  String convertToJson() => json.encode(toJson());

  factory UserInfo.convertfromJson(String source) =>
      UserInfo.fromJson(json.decode(source) as Map<String, dynamic>);
}

class Role {
  String id;
  String name;
  GuardName guardName;
  DateTime createdAt;
  DateTime updatedAt;
  RolePivot pivot;
  List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: RolePivot.fromJson(json["pivot"]),
        permissions: List<Permission>.from(
            json["permissions"].map((x) => Permission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
        "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
      };
}

enum GuardName { SANCTUM }

final guardNameValues = EnumValues({"sanctum": GuardName.SANCTUM});

class Permission {
  String id;
  String name;
  GuardName guardName;
  DateTime createdAt;
  DateTime updatedAt;
  PermissionPivot pivot;

  Permission({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: PermissionPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class PermissionPivot {
  String roleId;
  String permissionId;

  PermissionPivot({
    required this.roleId,
    required this.permissionId,
  });

  factory PermissionPivot.fromJson(Map<String, dynamic> json) =>
      PermissionPivot(
        roleId: json["role_id"],
        permissionId: json["permission_id"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "permission_id": permissionId,
      };
}

class RolePivot {
  String modelId;
  String roleId;
  String modelType;

  RolePivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  factory RolePivot.fromJson(Map<String, dynamic> json) => RolePivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
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
