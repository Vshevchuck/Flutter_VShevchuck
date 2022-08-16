import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import '../../models/push_notification_model.dart';


class PushNotification{
  static const String pushNotificationServerKey ="AAAAzmp6sfg:APA91bHYb6nFgJApW"
      "3H8iDiwzEfsciudHS-KGwraAqqle5E0547oUCfZAPWm2rFCnGbd-Eo1TTy3lRWYpQAEe3fgZ"
      "27xTgMNlzpWmpbm4vaTODSoMY1NAbPGVrkxQM19YTDkcrV_bTy-";
  static Future<void> push({required String to, required String title, required String body}) async
  {
    try{
      http.Response response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$pushNotificationServerKey',
          },
          body: jsonEncode(PushNotificationModel(
              notification: Notification(title: title, body: body), to: to)));
      if (response.statusCode == 200) {
      } else {
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }
}