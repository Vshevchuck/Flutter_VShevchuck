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
    if (event.runtimeType == List<String>) {
      print('+');
      FirebaseFirestore.instance.collection('chatrooms').add({
        'id_first_user': event[0],
        'id_second_user': event[1],
        'id': '${event[0]}-${event[1]}',
        'chat': <Map<String, String>>[]
      });
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        for (int i = snapshot.docs.length - 1; i >= 0; i--) {
          if (snapshot.docs[i].get('id') == event[0]) {
            Map<String, dynamic> chatrooms =
                snapshot.docs[i].get('chatrooms') as Map<String, dynamic>;
            chatrooms.addAll({'${event[0]}-${event[1]}': event[1]});
            FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.docs[i].id)
                .set({'chatrooms': chatrooms}, SetOptions(merge: true));
          }
          if (snapshot.docs[i].get('id') == event[1]) {
            Map<String, dynamic> chatrooms =
                snapshot.docs[i].get('chatrooms') as Map<String, dynamic>;
            chatrooms.addAll({'${event[0]}-${event[1]}': event[0]});
            FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.docs[i].id)
                .set({'chatrooms': chatrooms}, SetOptions(merge: true));
          }
        }
      });
      yield ChatRoomIdState('${event[0]}-${event[1]}');
    } else if (event.runtimeType == List<Object>) {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          if (snapshot.docs[i].get('id') == event[1].uid) {
            add([snapshot.docs[i].get('chatrooms'), event[0].id]);
          }
        }
      });
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
}
