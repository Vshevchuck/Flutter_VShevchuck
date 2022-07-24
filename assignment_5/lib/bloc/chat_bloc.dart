import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_state.dart';

class ChatBloc extends Bloc<dynamic, ChatState> {
  @override
  get initialState => ChatEmptyState();

  @override
  Stream<ChatState> mapEventToState(dynamic event) async* {
    bool sendList=false;
    if (event.runtimeType == String) {
      FirebaseFirestore.instance
      .collection('chatrooms')
      .doc(event)
      .snapshots()
      .listen((snapshot) {
      add(snapshot.data()!['chat']);
      });
    }
    try {
      if (event.runtimeType == List<dynamic>) {
        var document = await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event[0])
            .get();
        List<dynamic> chat = document.data()?['chat'];
        chat.add(event[1]);
        sendList=true;
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event[0])
            .set({'chat': chat}, SetOptions(merge: true));
        var documentUpdate = await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event[0])
            .get();
        var chatUpdate = documentUpdate.data()?['chat'] as List<dynamic>;
        chatUpdate.toList().reversed;
        yield ChatListState(chatUpdate);
      }
    } catch (_) {}
    if ((event.runtimeType == List<dynamic>) && !sendList) {
      yield ChatListState(event);
    }
  }
}
