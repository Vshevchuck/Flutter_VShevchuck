import 'package:cloud_firestore/cloud_firestore.dart';
class UserProvider {
  static dynamic getDataBase() {
    dynamic usersData;
    FirebaseFirestore.instance.collection('users').snapshots().listen((
        snapshot) {
          usersData=snapshot.docs;
    });
    return usersData;
  }
}