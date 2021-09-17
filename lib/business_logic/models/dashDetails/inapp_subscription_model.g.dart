// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inapp_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InAppSubscripition _$InAppSubscripitionFromJson(Map<String, dynamic> json) {
  return InAppSubscripition(
    success: json['success'] as bool,
    message: json['message'] as String,
    result: json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InAppSubscripitionToJson(InAppSubscripition instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    subDetailsId: json['subDetailsId'] as int,
    registrationId: json['registrationId'] as int,
    customerId: json['customerId'] as String,
    invoiceId: json['invoiceId'] as String,
    subscriptionId: json['subscriptionId'] as String,
    subscriptionRenew: json['subscriptionRenew'] == null
        ? null
        : DateTime.parse(json['subscriptionRenew'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    subscriptionPlanLessons: json['subscriptionPlanLessons'] as String,
    subscriptionPlanPrice: json['subscriptionPlanPrice'] as int,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'subDetailsId': instance.subDetailsId,
      'registrationId': instance.registrationId,
      'customerId': instance.customerId,
      'invoiceId': instance.invoiceId,
      'subscriptionId': instance.subscriptionId,
      'subscriptionRenew': instance.subscriptionRenew?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'createDate': instance.createDate?.toIso8601String(),
      'subscriptionPlanLessons': instance.subscriptionPlanLessons,
      'subscriptionPlanPrice': instance.subscriptionPlanPrice,
    };
