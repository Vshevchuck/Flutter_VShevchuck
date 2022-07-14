import 'package:assignment_5/bloc/users_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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