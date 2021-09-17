import 'dart:convert';

UserParamsResponse paramsResponseFromJson(String str) => UserParamsResponse.fromJson(json.decode(str));

String paramsResponseToJson(UserParamsResponse data) => json.encode(data.toJson());

class UserParamsResponse {
  UserParamsResponse({
    this.id,
    this.type,
  });

  String id;
  String type;

  factory UserParamsResponse.fromJson(Map<String, dynamic> json) => UserParamsResponse(
        id: json["id"],
        type: json["type"],
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,

    };
}