import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'inapp_subscription_model.g.dart';

InAppSubscripition inAppSubscripitionFromJson(String str) => InAppSubscripition.fromJson(json.decode(str));

String inAppSubscripitionToJson(InAppSubscripition data) => json.encode(data.toJson());

@JsonSerializable()
class InAppSubscripition {
    InAppSubscripition({
        this.success,
        this.message,
        this.result,
    });
    @JsonKey(nullable: true)
    bool success;
    @JsonKey(nullable: true)
    String message;
    @JsonKey(nullable: true)
    Result result;
    factory InAppSubscripition.fromJson(Map<String, dynamic> json) => _$InAppSubscripitionFromJson(json);

    Map<String, dynamic> toJson() => _$InAppSubscripitionToJson(this);
}
@JsonSerializable()
class Result {
    Result({
        this.subDetailsId,
        this.registrationId,
        this.customerId,
        this.invoiceId,
        this.subscriptionId,
        this.subscriptionRenew,
        this.modifyDate,
        this.createDate,
        this.subscriptionPlanLessons,
        this.subscriptionPlanPrice,
    });
    @JsonKey(nullable: true)
    int subDetailsId;
    @JsonKey(nullable: true)
    int registrationId;
    @JsonKey(nullable: true)
    String customerId;
    @JsonKey(nullable: true)
    String invoiceId;
    @JsonKey(nullable: true)
    String subscriptionId;
    @JsonKey(nullable: true)
    DateTime subscriptionRenew;
    @JsonKey(nullable: true)
    DateTime modifyDate;
    @JsonKey(nullable: true)
    DateTime createDate;
    @JsonKey(nullable: true)
    String subscriptionPlanLessons;
    @JsonKey(nullable: true)
    int subscriptionPlanPrice;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

    Map<String, dynamic> toJson() => _$ResultToJson(this);
}