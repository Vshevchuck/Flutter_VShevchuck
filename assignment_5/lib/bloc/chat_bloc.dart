import 'package:assignment_5/bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<dynamic, ChatState> {

  @override
  get initialState => ChatEmptyState();

  @override
  Stream<ChatState> mapEventToState(dynamic event) async* {
     if(event.runtimeType==String)
       {
         FirebaseFirestore.instance
             .collection('chatrooms')
             .snapshots()
             .listen((snapshot) {
               for(int i=0;i<snapshot.docs.length;i++)
                 {
                   if(snapshot.docs[i].get('id')==event)
                     {
                       add(snapshot.docs[i].get('chat'));
                     }
                 }
         });
       }
     if(event.runtimeType==Map<String,String>)
    {

    }
  }
}
