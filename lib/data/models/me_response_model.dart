import 'dart:convert';

class MeResponseModel {
    final Meta? meta;
    final Data? data;

    MeResponseModel({
        this.meta,
        this.data,
    });

    factory MeResponseModel.fromJson(String str) => MeResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MeResponseModel.fromMap(Map<String, dynamic> json) => MeResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data?.toMap(),
    };
}

class Data {
    final String? id;
    final String? username;
    final String? email;
    final String? password;
    final String? profileImage;
    final dynamic resetPasswordOtp;
    final DateTime? resetPasswordExpires;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    Data({
        this.id,
        this.username,
        this.email,
        this.password,
        this.profileImage,
        this.resetPasswordOtp,
        this.resetPasswordExpires,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        profileImage: json["profileImage"],
        resetPasswordOtp: json["resetPasswordOTP"],
        resetPasswordExpires: json["resetPasswordExpires"] == null ? null : DateTime.parse(json["resetPasswordExpires"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "profileImage": profileImage,
        "resetPasswordOTP": resetPasswordOtp,
        "resetPasswordExpires": resetPasswordExpires?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
