import 'package:assignment_5/bloc/chat_room_bloc/chat_room_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../generated/locale_keys.g.dart';
import 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  @override
  get initialState => ChatRoomEmptyState();

  @override
  Stream<ChatRoomState> mapEventToState(ChatRoomEvent event) async* {
    bool newRoom = true;
    String id = '';
    if (event is CreateChatRoomEvent) {
      id = await _addChat(event.usersId);
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        for (int i = snapshot.docs.length - 1; i >= 0; i--) {
          if (snapshot.docs[i].get('id') == event.usersId.first) {
            _addChatToUser(id, event.usersId[1], snapshot, i);
          }
          if (snapshot.docs[i].get('id') == event.usersId[1]) {
           _addChatToUser(id, event.usersId.first, snapshot, i);
          }
        }
      });
      yield ChatRoomIdState(id);
    } else if (event is FindChatRoomEvent) {
      _findUserChatRooms(event.users[1].uid, event.users.first.id);
    } else if (event is GetChatRoomEvent && event.chatrooms.isEmpty) {
      yield ChatRoomNewState();
    } else if(event is GetChatRoomEvent ){
      for (var item in event.chatrooms.first.entries) {
        if (item.value == event.chatrooms[1]) {
          newRoom = false;
          yield ChatRoomIdState(item.key);
        }
      }
      if (newRoom) {
        yield ChatRoomNewState();
      }
    }

  }

  void _findUserChatRooms(String loginedUserId, String secondUserId) {
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: loginedUserId)
        .snapshots()
        .listen((snapshot) {
      add(GetChatRoomEvent([snapshot.docs[0].get('chatrooms'), secondUserId]));
    });
  }

  void _addChatToUser(String id, String secondUser,
      QuerySnapshot<Map<String, dynamic>> snapshot, int i) {
    Map<String, dynamic> chatrooms =
        snapshot.docs[i].get('chatrooms') as Map<String, dynamic>;
    chatrooms.addAll({id: secondUser});
    FirebaseFirestore.instance
        .collection('users')
        .doc(snapshot.docs[i].id)
        .set({'chatrooms': chatrooms}, SetOptions(merge: true));
  }

  Future<String> _addChat(List<String> users) async {
    String id = '';
    await FirebaseFirestore.instance.collection('chatrooms').add({
      'id_first_user': users.first,
      'id_second_user': users[1],
      'id': '${users.first}-${users[1]}',
      'chat': [
        {'admin': LocaleKeys.Start_the_dialog.tr()}
      ],
      'lastMessage': ''
    }).then((value) => ((id = value.id)));
    return id;
  }
}
