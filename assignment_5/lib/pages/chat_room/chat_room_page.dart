import 'package:assignment_5/pages/chat_room/widgets/check_chat_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_room_bloc.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = (ModalRoute.of(context)?.settings.arguments) as List<dynamic>;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text(users[0].email)),
            body: BlocProvider<ChatRoomBloc>(
              create: (context) => ChatRoomBloc(),
              child: CheckChatRoomWidget(users: users),
            )));
  }
}

