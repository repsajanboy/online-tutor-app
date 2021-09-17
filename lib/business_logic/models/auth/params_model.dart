import 'dart:convert';

ParamsResponse paramsResponseFromJson(String str) => ParamsResponse.fromJson(json.decode(str));

String paramsResponseToJson(ParamsResponse data) => json.encode(data.toJson());

class ParamsResponse {
    ParamsResponse({
        this.id,
        this.email,
        this.type,
        this.timezoneinfoforce,
        this.timezoneinfo,
        this.timezone,
    });

    String id;
    String email;
    String type;
    int timezoneinfoforce;
    String timezoneinfo;
    String timezone;

    factory ParamsResponse.fromJson(Map<String, dynamic> json) => ParamsResponse(
        id: json["id"],
        email: json["email"],
        type: json["type"],
        timezoneinfoforce: json["timezoneinfoforce"],
        timezoneinfo: json["timezoneinfo"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "type": type,
        "timezoneinfoforce": timezoneinfoforce,
        "timezoneinfo": timezoneinfo,
        "timezone": timezone,
    };
}