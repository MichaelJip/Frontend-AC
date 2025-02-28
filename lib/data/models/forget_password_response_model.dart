import 'dart:convert';

class ForgetPasswordResponseModel {
    final Meta? meta;
    final dynamic data;

    ForgetPasswordResponseModel({
        this.meta,
        this.data,
    });

    factory ForgetPasswordResponseModel.fromJson(String str) => ForgetPasswordResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ForgetPasswordResponseModel.fromMap(Map<String, dynamic> json) => ForgetPasswordResponseModel(
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
        data: json["data"],
    );

    Map<String, dynamic> toMap() => {
        "meta": meta?.toMap(),
        "data": data,
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
