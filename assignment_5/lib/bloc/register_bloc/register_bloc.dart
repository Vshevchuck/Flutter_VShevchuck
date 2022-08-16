import 'package:assignment_5/bloc/register_bloc/register_state.dart';
import 'package:assignment_5/bloc/user_bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import '../../networking/firebase_auth_client.dart';

class RegisterBloc extends Bloc<dynamic, RegisterState> {
  @override
  get initialState => RegisterEmptyState();
  @override
  Stream<RegisterState> mapEventToState(dynamic event) async* {
    if (event.runtimeType == String) {
      yield RegisterEmptyState();
    }
    if (event.runtimeType == UserRegister) {
      final FirebaseAuthClient authClient = FirebaseAuthClient();
      dynamic authStatus = authClient.SignUp(event.email, event.password,event.name);
      if (authStatus is User) {
          yield UserRegisteredState(authStatus);
      }
      else{
        yield RegisterErrorState(_checkRegisterError(event, authStatus));
      }
    }
  }
  String _checkRegisterError(UserRegister user,FirebaseAuthException exception) {
    if (user.password.length < 6) {
      return ('password must be at least 6 characters');
    }
    if (user.email.isEmpty || user.password.isEmpty || user.name.isEmpty) {
      return ('Fill in all the fields');
    }
    if (!user.email.contains('.') || !user.email.contains('@')) {
      return ('invalid email input form , please check availability . or @');
    }
    return (exception.message.toString());
  }
}
