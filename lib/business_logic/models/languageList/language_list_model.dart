import 'dart:convert';

LanguageList languageListFromJson(String str) => LanguageList.fromJson(json.decode(str));

String languageListToJson(LanguageList data) => json.encode(data.toJson());

class LanguageList {
    LanguageList({
        this.success,
        this.message,
        this.result,
    });

    bool success;
    String message;
    List<LanguageResult> result;

    factory LanguageList.fromJson(Map<String, dynamic> json) => LanguageList(
        success: json["success"],
        message: json["message"],
        result: List<LanguageResult>.from(json["result"].map((x) => LanguageResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class LanguageResult {
    LanguageResult({
        this.iso,
        this.isoName,
    });

    String iso;
    String isoName;

    factory LanguageResult.fromJson(Map<String, dynamic> json) => LanguageResult(
        iso: json["iso"],
        isoName: json["isoName"],
    );

    Map<String, dynamic> toJson() => {
        "iso": iso,
        "isoName": isoName,
    };
}
