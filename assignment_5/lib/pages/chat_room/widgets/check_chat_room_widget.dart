import 'package:assignment_5/bloc/chat_room_bloc/chat_room_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_room_bloc/chat_room_bloc.dart';
import '../../../bloc/chat_room_bloc/chat_room_state.dart';
import '../../../generated/locale_keys.g.dart';
import 'chat_widget.dart';

class CheckChatRoomWidget extends StatelessWidget {
  final users;

  const CheckChatRoomWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatRoomBloc chatRoomBloc = BlocProvider.of<ChatRoomBloc>(context);
    chatRoomBloc.add(FindChatRoomEvent(users));
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (context, state) {
      if (state is ChatRoomNewState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               FittedBox(
                 fit: BoxFit.fitWidth,
                 alignment: Alignment.center,
                child: Text(LocaleKeys.You_have_not_started_a_dialog_with_this_user_yet.tr(),
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                   chatRoomBloc
                        .add(CreateChatRoomEvent([users[1].uid.toString(), users.first.id.toString()]));
                  },
                  child: Text(LocaleKeys.Create_dialog.tr())),
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