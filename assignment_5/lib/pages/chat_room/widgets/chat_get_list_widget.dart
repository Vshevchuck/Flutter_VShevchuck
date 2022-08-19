import 'dart:async';

import 'package:assignment_5/util/colors/colors_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_bloc/chat_bloc.dart';
import '../../../bloc/chat_bloc/chat_event.dart';
import '../../../bloc/chat_bloc/chat_state.dart';
import 'message_widget.dart';

class ChatGetListWidget extends StatelessWidget {
  final id;
  final userId;

  ChatGetListWidget({Key? key, required this.id, required this.userId})
      : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    final messageController = TextEditingController();
    chatBloc.add(GetChatId(id));
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatListState) {
        if (_scrollController.hasClients) {
          scheduleMicrotask(() => (_scrollController
              .jumpTo(_scrollController.position.minScrollExtent)));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.chat.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> messageAuth =
                        state.chat[index] as Map<String, dynamic>;
                    return MessageWidget(
                        userId: userId,
                        auth: messageAuth.entries.first.key,
                        message: messageAuth.entries.first.value);
                  }),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: ColorStyle.sendMessageContainerBorderColor,
                        width: 1.5),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(hintText: 'message'),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        chatBloc.add(SendMessage([
                          id,
                          {userId: messageController.text}
                        ]));
                        messageController.text = "";
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
