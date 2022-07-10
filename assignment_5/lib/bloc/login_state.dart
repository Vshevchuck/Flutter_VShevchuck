import 'package:firebase_auth/firebase_auth.dart';

class LoginState{}

class LoginEmptyState extends LoginState{}
class LoginErrorState extends LoginState{}

class UserLoginedState extends LoginState{
  final User user;
  UserLoginedState(this.user);
}