import 'package:assignment_5/pages/chat_room/widgets/check_chat_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_room_bloc/chat_room_bloc.dart';
import '../../util/colors/colors_style.dart';
import '../../util/decorations/decorations.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = (ModalRoute.of(context)?.settings.arguments) as List<dynamic>;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: ColorStyle.chatAppBarColor,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(users.first.name),
                        Text(users.first.email,style: const TextStyle(fontSize: 15),),
                      ],
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
          body: Container(
            decoration: Decorations.backgroundChatRoomDecoration,
            child: BlocProvider<ChatRoomBloc>(
              create: (context) => ChatRoomBloc(),
              child: CheckChatRoomWidget(users: users),
            ),
          )),
    );
  }
}
