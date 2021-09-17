import 'dart:convert';

GetUserResponse getUserResponseFromJson(String str) => GetUserResponse.fromJson(json.decode(str));

String getUserResponseToJson(GetUserResponse data) => json.encode(data.toJson());

class GetUserResponse {
    GetUserResponse({
        this.success,
        this.message,
        this.result,
    });

    bool success;
    String message;
    UserResponseResult result;

    factory GetUserResponse.fromJson(Map<String, dynamic> json) => GetUserResponse(
        success: json["success"],
        message: json["message"],
        result: UserResponseResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": result.toJson(),
    };
}

class UserResponseResult {
    UserResponseResult({
        this.registrationId,
        this.profileType,
        this.subscriptionStatus
    });

    int registrationId;
    String profileType;
    int subscriptionStatus;

    factory UserResponseResult.fromJson(Map<String, dynamic> json) => UserResponseResult(
        registrationId: json["registrationId"],
        profileType: json["profileType"],
        subscriptionStatus: json["subscriptionStatus"],
    );

    Map<String, dynamic> toJson() => {
        "registrationId": registrationId,
        "profileType": profileType,
        "subscriptionStatus": subscriptionStatus,
    };
}
