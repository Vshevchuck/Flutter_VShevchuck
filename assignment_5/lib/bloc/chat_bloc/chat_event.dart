class  ChatEvent{}

class GetChatId extends ChatEvent{
  final String chatId;
  GetChatId(this.chatId);
}
class GetReversedChat extends ChatEvent{
  final List<dynamic> chat;
  GetReversedChat(this.chat);
}

class SendMessage extends ChatEvent {
  final List<dynamic> idChatAndMessage;
  SendMessage(this.idChatAndMessage);
}