import '../user_bloc/user_event.dart';

class ChatRoomEvent{}

class FindChatRoomEvent extends ChatRoomEvent{
  final ourUser;
  final secondUser;
  FindChatRoomEvent(this.ourUser,this.secondUser);
}

class GetChatRoomEvent extends ChatRoomEvent{
  final Map<String,dynamic> chatroom;
  final String secondUserId;
  GetChatRoomEvent(this.chatroom,this.secondUserId);
}

class CreateChatRoomEvent extends ChatRoomEvent{
  final String OurId;
  final String IdSecondUser;
  CreateChatRoomEvent(this.OurId,this.IdSecondUser);
}
