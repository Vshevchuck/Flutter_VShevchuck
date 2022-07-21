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
      print(event);
      var document = await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(event)
          .get();
      print(document.data()?['chat'][0]['admin']);
      add(document.data()?['chat']);

      //FirebaseFirestore.instance
      //.collection('chatrooms')
      //.doc(event)
      //.snapshots()
      //.listen((snapshot) {
      //add(snapshot.data()!['chat'] as List<Map<String, String>>);
      //});
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
        var chatUpdate = documentUpdate.data()?['chat'];
        print(documentUpdate);
        yield ChatListState(chatUpdate);
      }
    } catch (_) {
      print('-');
    }
    ;
    if ((event.runtimeType == List<dynamic>) && !sendList) {
      print('+');
      yield ChatListState(event);
    }
  }
}
