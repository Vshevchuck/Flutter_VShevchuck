import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import '../generated/locale_keys.g.dart';

class Firestore {
  final firestore = FirebaseFirestore.instance;

  Stream listenUserbyId(String userId) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: userId)
        .snapshots();
  }

  Stream listenUsers() {
    return firestore.collection('users').snapshots();
  }

  Stream listenChatRoomById(String chatId) {
    return firestore.collection('chatrooms').doc(chatId).snapshots();
  }

  Stream checkLastMessageAndGetListUsers() {
    return firestore.collection('chatrooms').orderBy('lastMessage').snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addChat(
      String idFirstUser, idSecondUser) async {
    return await FirebaseFirestore.instance.collection('chatrooms').add({
      'id_first_user': idFirstUser,
      'id_second_user': idSecondUser,
      'id': '$idFirstUser-$idSecondUser',
      'chat': [
        {'admin': LocaleKeys.Start_the_dialog.tr()}
      ],
      'lastMessage': ''
    });
  }

  void addChatToUser(QuerySnapshot<Map<String, dynamic>> snapshot, int i,
      Map<String, dynamic> chatrooms) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(snapshot.docs[i].id)
        .set({'chatrooms': chatrooms}, SetOptions(merge: true));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserWithId(String key) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: key)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatroomWithId(
      String id) async {
    return await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('id', isEqualTo: id)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getChatroomById(
      String id) async {
    return await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(id)
        .get();
  }

  void addNewMassageToFirestore(
      String id, List<dynamic> chat, String message) async {
    await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(id)
        .set({'chat': chat, 'lastMessage': message}, SetOptions(merge: true));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }
}
