import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
class Firestore{
  final firestore = FirebaseFirestore.instance;
  Stream checkLastMessageAndGetListUsers() {
    return firestore
        .collection('chatrooms').orderBy('lastMessage')
        .snapshots();
    }
    Future<QuerySnapshot<Map<String, dynamic>>> getChatroomWithId(String id)
    async {
      return await FirebaseFirestore.instance
          .collection('chatrooms')
          .where('id', isEqualTo: id)
          .get();
    }
  Future<QuerySnapshot<Map<String, dynamic>>> getUsers()
  async {
    return await FirebaseFirestore.instance
        .collection('users')
        .get();
  }


}