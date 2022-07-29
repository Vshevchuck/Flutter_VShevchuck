import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_room_bloc.dart';
import '../../../bloc/chat_room_state.dart';
import 'chat_widget.dart';

class CheckChatRoomWidget extends StatelessWidget {
  final users;

  const CheckChatRoomWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatRoomBloc userBloc = BlocProvider.of<ChatRoomBloc>(context);
    userBloc.add(users);
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (context, state) {
      if (state is ChatRoomNewState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'You have not started a dialog with this user yet',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    userBloc
                        .add([users[1].uid.toString(), users.first.id.toString()]);
                  },
                  child: const Text('Create dialog')),
            ],
          ),
        );
      }
      if (state is ChatRoomIdState) {
        return ChatWidget(id: state.chatRoomId, userId: users[1].uid.toString());
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}