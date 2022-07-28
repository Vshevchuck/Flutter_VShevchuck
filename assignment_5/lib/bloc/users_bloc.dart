import 'dart:math';

import 'package:assignment_5/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<dynamic, UserState> {
  List<dynamic> usersAndLastMessage = <dynamic>[];

  @override
  get initialState => UserLoadingState();
  String id = '';

  @override
  Stream<UserState> mapEventToState(dynamic event) async* {
    if (event.runtimeType == String) {
      id = event;
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        add(snapshot.docs);
      });
    }
    if (event != null) {
      String lastMessage = '-';
      try {
        for (int i = 0; i < event.length; i++) {
          UserModel userInList = UserModel.fromJson(event[i].data());
          try {
            //print(FirebaseFirestore.instance
            //.collection('chatrooms')
            //.where('id', isEqualTo: '$id-${userInList.id}').get().then((
            //snapshot) { print(snapshot.docs[0].get('lastMessage'));}));
            FirebaseFirestore.instance
                .collection('chatrooms')
                .where('id', isEqualTo: '$id-${userInList.id}')
                .snapshots()
                .listen((snapshot) {
                  print(snapshot.docs);
              if (snapshot.docs.isNotEmpty) {
                lastMessage = snapshot.docs[0].get('lastMessage');
                print(lastMessage);
              }
            });
          } catch (_) {
            print("+");
          }
          FirebaseFirestore.instance
              .collection('chatrooms')
              .where('id', isEqualTo: '${userInList.id}-$id')
              .snapshots()
              .listen((snapshot) {
            if (snapshot.docs.isNotEmpty) {
              lastMessage = snapshot.docs[0].get('lastMessage');
            }
          });
          usersAndLastMessage.add([userInList, lastMessage]);
        }
        yield UserLoadedState(usersAndLastMessage);
      } catch (_) {
      }
    }
  }
}
