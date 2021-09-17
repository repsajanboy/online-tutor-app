// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeSubscription _$StripeSubscriptionFromJson(Map<String, dynamic> json) {
  return StripeSubscription(
    success: json['success'] as bool,
    message: json['message'] as String,
    stripeCustomerId: json['stripeCustomerId'] as String,
    subStatus: json['subStatus'] as int,
    subPlanLessons: json['subPlanLessons'] as int,
    subPlanPrice: json['subPlanPrice'] as int,
  );
}

Map<String, dynamic> _$StripeSubscriptionToJson(StripeSubscription instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'stripeCustomerId': instance.stripeCustomerId,
      'subStatus': instance.subStatus,
      'subPlanLessons': instance.subPlanLessons,
      'subPlanPrice': instance.subPlanPrice,
    };
