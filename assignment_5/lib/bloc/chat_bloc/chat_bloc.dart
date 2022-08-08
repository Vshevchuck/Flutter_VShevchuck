import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  @override
  get initialState => ChatEmptyState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is GetChatId) {
      try {
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event.chatId)
            .snapshots()
            .listen((snapshot) {
          add(GetReversedChat(snapshot.data()!['chat']));
        });
      } catch (e) {
        print(e);
      }
    }
    try {
      if (event is SendMessage) {
        changeChatList(event.idChatAndMessage.first, event.idChatAndMessage[1]);
        yield ChatListState(
            getNewReversedChatList(event.idChatAndMessage.first));
      }
    } catch (_) {}
    if (event is GetReversedChat) {
      var reversed = event.chat.reversed.toList();
      yield ChatListState(reversed);
    }
  }

  getNewReversedChatList(String id) async {
    var documentUpdate =
        await FirebaseFirestore.instance.collection('chatrooms').doc(id).get();
    var chatUpdate = (documentUpdate.data()?['chat'] as List<dynamic>);
    return chatUpdate.reversed.toList();
  }

  void changeChatList(String id, dynamic message) async {
    var document =
        await FirebaseFirestore.instance.collection('chatrooms').doc(id).get();
    List<dynamic> chat = document.data()?['chat'];
    chat.add(message);
    var messageAuth = message as Map<dynamic, String>;
    for (var item in messageAuth.entries) {
      message = item.value;
    }
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(id)
        .set({'chat': chat, 'lastMessage': message}, SetOptions(merge: true));
  }
}
