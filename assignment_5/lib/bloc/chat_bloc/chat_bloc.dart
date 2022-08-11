import 'package:assignment_5/push_notifications/push_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        _changeChatList(event.idChatAndMessage.first, event.idChatAndMessage[1]);
        yield ChatListState(
            _getNewReversedChatList(event.idChatAndMessage.first));
      }
    } catch (_) {}
    if (event is GetReversedChat) {
      var reversed = event.chat.reversed.toList();
      yield ChatListState(reversed);
    }
  }

  _getNewReversedChatList(String id) async {
    var documentUpdate =
        await FirebaseFirestore.instance.collection('chatrooms').doc(id).get();
    var chatUpdate = (documentUpdate.data()?['chat'] as List<dynamic>);
    return chatUpdate.reversed.toList();
  }

  void _changeChatList(String id, dynamic message) async {
    String to='';
    var document =
        await FirebaseFirestore.instance.collection('chatrooms').doc(id).get();
    List<dynamic> chat = document.data()?['chat'];
    chat.add(message);
    var key;
    var messageAuth = message as Map<dynamic, String>;
    for (var item in messageAuth.entries) {
      message = item.value;
      key=item.key;
    }
    await _pushNotification(key, document, to, message);
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(id)
        .set({'chat': chat, 'lastMessage': message}, SetOptions(merge: true));
  }

  Future <void> _pushNotification(
      String key,var document,String to,String message)async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: key)
        .get();
    if(user.docs[0].get('id')==document.data()?['id_first_user'])
    {
      to=document.data()?['id_second_user'];
    }
    else{
      to=document.data()?['id_first_user'];
    }
    var userTo = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: to)
        .get();
    await PushNotification.push(
        to: userTo.docs[0].get('device_id'),
        title: "Message from ${user.docs[0].get('name')}",
        body: message
    );
  }

}
