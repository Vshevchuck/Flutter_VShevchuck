import '../user_bloc/user_event.dart';

class ChatRoomEvent{}

class FindChatRoomEvent extends ChatRoomEvent{
  final List<dynamic> users;
  FindChatRoomEvent(this.users);
}

class GetChatRoomEvent extends ChatRoomEvent{
  final List<dynamic> chatrooms;
  GetChatRoomEvent(this.chatrooms);
}

class CreateChatRoomEvent extends ChatRoomEvent{
  final List<String> usersId;
  CreateChatRoomEvent(this.usersId);
}
