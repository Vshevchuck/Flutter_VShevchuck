import 'dart:math';

import 'package:assignment_5/bloc/chat_room_bloc/chat_room_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  @override
  get initialState => ChatEmptyState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    bool sendList = false;
    if (event is GetChatId) {
      try {
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event.chatId)
            .snapshots()
            .listen((snapshot) {
          add(GetReversedChat(snapshot.data()!['chat']));
        });
      } catch (_) {}
    }
    try {
      String message = '';
      if (event is SendMessage) {
        var document = await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event.idChatAndMessage.first)
            .get();
        List<dynamic> chat = document.data()?['chat'];
        chat.add(event.idChatAndMessage[1]);
        var messageAuth = event.idChatAndMessage[1] as Map<dynamic, String>;
        for (var item in messageAuth.entries) {
          message = item.value;
        }
        sendList = true;
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event.idChatAndMessage.first)
            .set({'chat': chat, 'lastMessage': message},
                SetOptions(merge: true));
        var documentUpdate = await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(event.idChatAndMessage.first)
            .get();
        var chatUpdate = (documentUpdate.data()?['chat'] as List<dynamic>);
        var reversed = chatUpdate.reversed.toList();
        yield ChatListState(reversed);
      }
    } catch (_) {
      print('+');
    }
    if (event is GetReversedChat) {
      var reversed = event.chat.reversed.toList();
      yield ChatListState(reversed);
    }
  }
}
