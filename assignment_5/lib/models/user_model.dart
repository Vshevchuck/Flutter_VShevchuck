import 'package:firebase_auth/firebase_auth.dart';

class UserRegister{
  final String name;
  final String email;
  final String password;
  UserRegister(this.name, this.email,this.password);
}

class UserLogin{
  final String email;
  final String password;
  UserLogin(this.email,this.password);
}