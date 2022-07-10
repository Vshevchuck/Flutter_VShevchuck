import 'package:firebase_auth/firebase_auth.dart';

class RegisterState{}

class RegisterEmptyState extends RegisterState{}
class RegisterErrorState extends RegisterState{}

class UserRegisteredState extends RegisterState{
  final User user;
  UserRegisteredState(this.user);
}