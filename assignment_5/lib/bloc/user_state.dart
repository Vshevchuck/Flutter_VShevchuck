import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class  UserState{}

class UserLoadingState extends UserState{
}
class UserEmptyState extends UserState{}
class UserErrorState extends UserState{}

class UserLoadedState extends UserState{
  List<dynamic> loadedUsers;
  UserLoadedState(this.loadedUsers);
}