import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<dynamic, ChatRoomState> {
  @override
  get initialState => ChatRoomEmptyState();

  @override
  Stream<ChatRoomState> mapEventToState(dynamic event) async* {
    print(event.runtimeType);
    if (event.runtimeType == List<String>) {
      FirebaseFirestore.instance.collection('chatrooms').add({
        'id_first_user': event[1],
        'id_second_user': event[0],
        'id': '${event[1]}-${event[0]}'
      });
    }
    if (event.runtimeType == List<Object>) {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          if (snapshot.docs[i].get('id') == event[1].uid) {
            add(snapshot.docs[i].get('chatrooms'));
          }
        }
      });
    } else if (event != null) {
      if (event.isEmpty) {
        yield ChatRoomNewState();
      } else {
        for (var item in event.entries) {
          if (item.value == event[0].uid) {
            yield ChatRoomIdState(item.key);
          }
        }
      }
    }
  }
}
