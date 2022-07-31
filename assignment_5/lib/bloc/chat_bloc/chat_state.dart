class ChatState{}

class ChatEmptyState extends ChatState{}
class ChatErrorState extends ChatState{}

class ChatListState extends ChatState{
  final List<dynamic> chat;
  ChatListState(this.chat);
}