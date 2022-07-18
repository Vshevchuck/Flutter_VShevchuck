import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_room_bloc.dart';
import '../../bloc/chat_room_state.dart';
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
      if(state is ChatRoomIdState)
        {
          return Chat(id:state.chatRoomId);
        }
      return Text('dasda');
    });
  }
}
class Chat extends StatelessWidget {
  final id;
  const Chat({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

