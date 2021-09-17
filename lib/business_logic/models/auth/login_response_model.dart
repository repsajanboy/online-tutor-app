import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.success,
        this.message,
        this.id,
        this.email,
        this.type,
        this.timezoneinfoforce,
        this.timezoneinfo,
        this.timezone,
    });

    bool success;
    String message;
    String id;
    String email;
    String type;
    int timezoneinfoforce;
    String timezoneinfo;
    String timezone;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
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
        "id": id,
        "email": email,
        "type": type,
        "timezoneinfoforce": timezoneinfoforce,
        "timezoneinfo": timezoneinfo,
        "timezone": timezone,
    };
}