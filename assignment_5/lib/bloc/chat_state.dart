class ChatState{}

class ChatEmptyState extends ChatState{}
class ChatErrorState extends ChatState{}

class ChatListState extends ChatState{
  final List<Map<String,String>> chat;
  ChatListState(this.chat);
}