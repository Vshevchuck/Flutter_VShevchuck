import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_bloc/chat_bloc.dart';
import '../chat_room_page.dart';
import 'chat_get_list_widget.dart';

class ChatWidget extends StatelessWidget {
  final id;
  final userId;

  const ChatWidget({Key? key, required this.id, required this.userId})
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
