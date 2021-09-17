import 'dart:convert';

SignupResponse signpResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signpResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
    SignupResponse({
        this.success,
        this.message,
        this.referralCode,
        this.id,
        this.email,
        this.type,
        this.timezoneinfoforce,
        this.timezoneinfo,
        this.timezone,
    });

    bool success;
    String message;
    String referralCode;
    String id;
    String email;
    String type;
    int timezoneinfoforce;
    String timezoneinfo;
    String timezone;

    factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        success: json["success"],
        message: json["message"],
        referralCode: json["referralCode"],
        id: json["id"],
        email: json["email"],
        type: json["type"],
        timezoneinfoforce: json["timezoneinfoforce"],
        timezoneinfo: json["timezoneinfo"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "referralCode": referralCode,
        "id": id,
        "email": email,
        "type": type,
        "timezoneinfoforce": timezoneinfoforce,
        "timezoneinfo": timezoneinfo,
        "timezone": timezone,
    };
}