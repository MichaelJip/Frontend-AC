import 'dart:convert';

class AllUserResponseModel {
    final Meta? meta;
    final List<Datum>? data;
    final Pagination? pagination;

    AllUserResponseModel({
        this.meta,
        this.data,
        this.pagination,
    });

    factory AllUserResponseModel.fromJson(String str) => AllUserResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllUserResponseModel.fromMap(Map<String, dynamic> json) => AllUserResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
    );

    Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "pagination": pagination?.toMap(),
    };
}

class Datum {
    final String? id;
    final String? username;
    final String? email;
    final DateTime? createdAt;

    Datum({
        this.id,
        this.username,
        this.email,
        this.createdAt,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "email": email,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Meta {
    final int? status;
    final String? message;

    Meta({
        this.status,
        this.message,
    });

    factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}

class Pagination {
    final int? total;
    final int? totalPages;
    final int? current;

    Pagination({
        this.total,
        this.totalPages,
        this.current,
    });

    factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        totalPages: json["totalPages"],
        current: json["current"],
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "totalPages": totalPages,
        "current": current,
    };
}
