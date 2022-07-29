import 'package:assignment_5/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<dynamic, UserState> {
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
      List<dynamic> usersAndLastMessage = <dynamic>[];
      try {
        for (int i = 0; i < event.length; i++) {
          String lastMessage = 'you did not start message';
          UserModel userInList = UserModel.fromJson(event[i].data());
          var getLastMessage = await FirebaseFirestore.instance
              .collection('chatrooms')
              .where('id', isEqualTo: '$id-${userInList.id}')
              .get();
          if (getLastMessage.docs.isNotEmpty) {
            lastMessage = getLastMessage.docs.first.get('lastMessage');
          } else {
            getLastMessage = await FirebaseFirestore.instance
                .collection('chatrooms')
                .where('id', isEqualTo: '${userInList.id}-$id')
                .get();
            if (getLastMessage.docs.isNotEmpty) {
              lastMessage = getLastMessage.docs.first.get('lastMessage');
            }
          }
          usersAndLastMessage.add([userInList, lastMessage]);
        }
        yield UserLoadedState(usersAndLastMessage);
      } catch (_) {}
    }
  }

}
