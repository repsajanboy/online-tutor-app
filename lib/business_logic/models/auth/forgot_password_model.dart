import 'dart:convert';

ForgetResponse forgetResponseFromJson(String str) => ForgetResponse.fromJson(json.decode(str));

String forgetResponseToJson(ForgetResponse data) => json.encode(data.toJson());

class ForgetResponse {
    ForgetResponse({
        this.success,
        this.message,
        this.id,
        this.email,
        this.verificationCode,

    });

    bool success;
    String message;
    String id;
    String email;
    String verificationCode;


    factory ForgetResponse.fromJson(Map<String, dynamic> json) => ForgetResponse(
        success: json["success"],
        message: json["message"],
        id: json["id"],
        email: json["email"],
        verificationCode: json["verificationCode"],

    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "id": id,
        "email": email,
        "verificationCode": verificationCode,
    };
}