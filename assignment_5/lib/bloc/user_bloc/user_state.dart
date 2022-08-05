class  UserState{}

class UserLoadingState extends UserState{
}
class UserEmptyState extends UserState{}
class UserErrorState extends UserState{}
class ListenLastMessage extends UserState{}

class UserLoadedState extends UserState{
  List<dynamic> loadedUsers;
  UserLoadedState(this.loadedUsers);
}