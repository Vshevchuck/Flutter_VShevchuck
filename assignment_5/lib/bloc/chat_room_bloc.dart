import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<dynamic, ChatRoomState> {
  @override
  get initialState => ChatRoomEmptyState();

  @override
  Stream<ChatRoomState> mapEventToState(dynamic event) async* {
    bool newRoom = true;
    String id = '';
    if (event.runtimeType == List<String>) {
      addChat(event);
      FirebaseFirestore.instance
          .collection('chatrooms')
          .snapshots()
          .listen((snapshot) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          if (snapshot.docs[i].get('id') == '${event[0]}-${event[1]}') {
            id = snapshot.docs[i].id;
          }
        }
      });
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        for (int i = snapshot.docs.length - 1; i >= 0; i--) {
          if (snapshot.docs[i].get('id') == event[0]) {
            addChatToUser(id, event[1], snapshot, i);
          }
          if (snapshot.docs[i].get('id') == event[1]) {
            addChatToUser(id, event[0], snapshot, i);
          }
        }
      });
      yield ChatRoomIdState(id);
    } else if (event.runtimeType == List<Object>) {
      findUserChatRooms(event[1].uid, event[0].id);
    } else if (event != null) {
      if (event.isEmpty) {
        yield ChatRoomNewState();
      } else {
        for (var item in event[0].entries) {
          if (item.value == event[1]) {
            newRoom = false;
            yield ChatRoomIdState(item.key);
          }
        }
        if (newRoom) {
          yield ChatRoomNewState();
        }
      }
    }
  }



  void findUserChatRooms(String loginedUserId, String secondUserId) {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      for (int i = 0; i < snapshot.docs.length; i++) {
        if (snapshot.docs[i].get('id') == loginedUserId) {
          add([snapshot.docs[i].get('chatrooms'), secondUserId]);
        }
      }
    });
  }

  void addChatToUser(String id, String secondUser,
      QuerySnapshot<Map<String, dynamic>> snapshot, int i) {
    Map<String, dynamic> chatrooms =
        snapshot.docs[i].get('chatrooms') as Map<String, dynamic>;
    chatrooms.addAll({id: secondUser});
    FirebaseFirestore.instance
        .collection('users')
        .doc(snapshot.docs[i].id)
        .set({'chatrooms': chatrooms}, SetOptions(merge: true));
  }

  void addChat(List<String> users) {
    FirebaseFirestore.instance.collection('chatrooms').add({
      'id_first_user': users[0],
      'id_second_user': users[1],
      'id': '${users[0]}-${users[1]}',
      'chat': [
        {'admin': 'start the dialog'}
      ]
    });
  }
}
