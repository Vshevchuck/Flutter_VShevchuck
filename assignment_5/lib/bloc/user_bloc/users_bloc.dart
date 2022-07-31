import 'package:assignment_5/bloc/user_bloc/user_event.dart';
import 'package:assignment_5/bloc/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  get initialState => UserLoadingState();
  String id = '';

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadingEvent) {
      id = event.userID;
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        add(UserLoadedEvent(snapshot.docs));
      });
    }
    if (event is UserLoadedEvent) {
      List<dynamic> usersAndLastMessage = <dynamic>[];
      try {
        for (int i = 0; i < event.docs.length; i++) {
          String lastMessage = 'you did not start message';
          UserModel userInList = UserModel.fromJson(event.docs[i].data());
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
