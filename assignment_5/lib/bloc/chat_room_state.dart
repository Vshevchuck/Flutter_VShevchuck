class ChatRoomState{}

class ChatRoomEmptyState extends ChatRoomState{}
class ChatRoomErrorState extends ChatRoomState{}
class ChatRoomNewState extends ChatRoomState{}
class ChatRoomCreatedState extends ChatRoomState{}

class ChatRoomIdState extends ChatRoomState{
  final String chatRoomId;
  ChatRoomIdState(this.chatRoomId);
}