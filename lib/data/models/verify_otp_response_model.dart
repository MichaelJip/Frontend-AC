import 'dart:convert';

class VerifyOtpResponseModel {
    final Meta? meta;
    final dynamic data;

    VerifyOtpResponseModel({
        this.meta,
        this.data,
    });

    factory VerifyOtpResponseModel.fromJson(String str) => VerifyOtpResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VerifyOtpResponseModel.fromMap(Map<String, dynamic> json) => VerifyOtpResponseModel(
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
