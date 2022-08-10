// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


import 'push_notification_model.dart';


PushNotificationModel $PushNotificationModelFromJson(
    Map<String, dynamic> json) =>
    PushNotificationModel(
      notification:
      Notification.fromJson(json['notification'] as Map<String, dynamic>),
      to: json['to'] as String,
    );

Map<String, dynamic> $PushNotificationModelToJson(
    PushNotificationModel instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'to': instance.to,
    };

Notification $NotificationFromJson(Map<String, dynamic> json) => Notification(
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> $NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };