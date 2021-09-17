import 'dart:convert';

ResetResponse resetResponseFromJson(String str) => ResetResponse.fromJson(json.decode(str));

String resetResponseToJson(ResetResponse data) => json.encode(data.toJson());

class ResetResponse {
    ResetResponse({
        this.regId,
        this.id,
        this.email,
        this.verificationCode,

    });

    bool regId;
    String id;
    String email;
    String verificationCode;


    factory ResetResponse.fromJson(Map<String, dynamic> json) => ResetResponse(
        regId: json["regId"],
        id: json["id"],
        email: json["email"],
        verificationCode: json["verificationCode"],

    );

    Map<String, dynamic> toJson() => {
        "regId": regId,
        "id": id,
        "email": email,
        "verificationCode": verificationCode,
    };
}