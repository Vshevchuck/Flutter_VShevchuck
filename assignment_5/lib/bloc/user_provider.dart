import 'package:cloud_firestore/cloud_firestore.dart';
class UserProvider {
  static dynamic getDataBase() {
    dynamic usersData;
    FirebaseFirestore.instance.collection('users').snapshots().listen((
        snapshot) {
          usersData=snapshot.docs;
          print(usersData[0].data());
    });
    print(usersData);
    return usersData;
  }
}