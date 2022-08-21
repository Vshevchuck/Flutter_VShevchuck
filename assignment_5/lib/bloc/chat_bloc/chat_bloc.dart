import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../networking/firestore.dart';
import '../../networking/push_notifications/push_notification.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Firestore firestore = Firestore();

  @override
  get initialState => ChatEmptyState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is GetChatId) {
      try {
        firestore.listenChatRoomById(event.chatId).listen((snapshot) async {
          add(GetReversedChat(snapshot.data()!['chat']));
        });
      } catch (e) {
        print(e);
      }
    }
    try {
      if (event is SendMessage) {
        _changeChatList(event.idChatRoom, event.messageAndAuth);
        yield ChatListState(
            _getNewReversedChatList(event.idChatRoom));
      }
    } catch (_) {}
    if (event is GetReversedChat) {
      var reversed = event.chat.reversed.toList();
      yield ChatListState(reversed);
    }
  }

  _getNewReversedChatList(String id) async {
    var documentUpdate =
        await firestore.getChatroomById(id);
    var chatUpdate = (documentUpdate.data()?['chat'] as List<dynamic>);
    return chatUpdate.reversed.toList();
  }

  void _changeChatList(String id, dynamic message) async {
    String to='';
    var document =
        await firestore.getChatroomById(id);
    List<dynamic> chat = document.data()?['chat'];
    chat.add(message);
    var key;
    var messageAuth = message as Map<String,dynamic>;
    for (var item in messageAuth.entries) {
      message = item.value;
      key=item.key;
    }
    await _pushNotification(key, document, to, message);
    firestore.addNewMassageToFirestore(id, chat, message);
  }

  Future <void> _pushNotification(
      String key,var document,String to,String message)async {
    var user = await firestore.getUserWithId(key);
    if(user.docs.first.get('id')==document.data()?['id_first_user'])
    {
      to=document.data()?['id_second_user'];
    }
    else{
      to=document.data()?['id_first_user'];
    }
    var userTo = await firestore.getUserWithId(to);
    await PushNotification.push(
        to: userTo.docs.first.get('device_id'),
        title: "Message from ${user.docs.first.get('name')}",
        body: message
    );
  }
}
