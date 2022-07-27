import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_bloc.dart';
import '../../../bloc/chat_state.dart';

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
    chatBloc.add(id);
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatListState) {
        if (_scrollController.hasClients) {
          scheduleMicrotask(
                  () =>(_scrollController.jumpTo(_scrollController.position.minScrollExtent)));
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
                    String message = 'message';
                    String auth = 'auth';
                    var messageAuth = state.chat[index] as Map<String, dynamic>;
                    for (var item in messageAuth.entries) {
                      message = item.value;
                      auth = item.key;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: auth == userId
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: FittedBox(
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                              alignment: auth == userId
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                auth == userId ? Colors.blue : Colors.grey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    constraints:
                                    const BoxConstraints(maxWidth: 250),
                                    child: Text(
                                        softWrap: true,
                                        message,
                                        style: _style)),
                              )),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.5),
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
                        chatBloc.add([
                          id,
                          {userId: messageController.text}
                        ]);
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

  final TextStyle _style = const TextStyle(color: Colors.white, fontSize: 15);
}