import 'package:flutter/src/widgets/framework.dart';

class  UserEvent{}

class UserLoadingEvent extends UserEvent{
  final String userID;
  UserLoadingEvent(this.userID);
}

class UserLoadedEvent extends UserEvent{
  final docs;
  UserLoadedEvent(this.docs);
}
class UserLogOutEvent extends UserEvent{}
