import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'stripe_subscription_model.g.dart';

StripeSubscription stripeSubscriptionFromJson(String str) =>
    StripeSubscription.fromJson(json.decode(str));

String stripeSubscriptionToJson(StripeSubscription data) =>
    json.encode(data.toJson());

@JsonSerializable()
class StripeSubscription {
  StripeSubscription({
    this.success,
    this.message,
    this.stripeCustomerId,
    this.subStatus,
    this.subPlanLessons,
    this.subPlanPrice,
  });
  @JsonKey(nullable: true)
  bool success;
  @JsonKey(nullable: true)
  String message;
  @JsonKey(nullable: true)
  String stripeCustomerId;
  @JsonKey(nullable: true)
  int subStatus;
  @JsonKey(nullable: true)
  int subPlanLessons;
  @JsonKey(nullable: true)
  int subPlanPrice;

  factory StripeSubscription.fromJson(Map<String, dynamic> json) =>
      _$StripeSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$StripeSubscriptionToJson(this);
}
