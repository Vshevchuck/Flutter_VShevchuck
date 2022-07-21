import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_bloc.dart';
import '../../bloc/chat_room_bloc.dart';
import '../../bloc/chat_room_state.dart';
import '../../bloc/chat_state.dart';
import '../../bloc/register_state.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = (ModalRoute.of(context)?.settings.arguments) as List<dynamic>;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text(users[0].email)),
            body: BlocProvider<ChatRoomBloc>(
              create: (context) => ChatRoomBloc(),
              child: CheckChatRoom(users: users),
            )));
  }
}

class CheckChatRoom extends StatelessWidget {
  final users;

  const CheckChatRoom({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatRoomBloc userBloc = BlocProvider.of<ChatRoomBloc>(context);
    userBloc.add(users);
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (context, state) {
      if (state is ChatRoomNewState) {
        return ElevatedButton(
            onPressed: () {
              userBloc.add([users[1].uid.toString(), users[0].id.toString()]);
            },
            child: const Text('Create dialog'));
      }
      if (state is ChatRoomIdState) {
        return Chat(id: state.chatRoomId, userId: users[1].uid.toString());
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

class Chat extends StatelessWidget {
  final id;
  final userId;

  const Chat({Key? key, required this.id, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(),
        child: ChatGetListWidget(
          id: id,
          userId: userId,
        ));
  }
}

class ChatGetListWidget extends StatelessWidget {
  final id;
  final userId;

  const ChatGetListWidget({Key? key, required this.id, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    final messageController = TextEditingController();
    chatBloc.add(id);
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatListState) {
        return Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: state.chat.length,
                itemBuilder: (context, index) {
                  String message = 'message';
                  try{
                    if(state.chat[index][userId]!=null)
                      {
                        message= state.chat[index][userId];
                      }
                  }
                  catch(_){
                    message='message';
                  }
                  return Text(message);
                }),
            Row(
              children: [
                Container(width:200,child: TextField(controller: messageController)),
                IconButton(
                    onPressed: () {
                      chatBloc.add([id,{userId: messageController.text}]);
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
