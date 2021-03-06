import 'package:assignment_5/bloc/register_bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class RegisterBloc extends Bloc<dynamic, RegisterState> {
  @override
  get initialState => RegisterEmptyState();

  @override
  Stream<RegisterState> mapEventToState(dynamic event) async* {
    if (event.runtimeType == String) {
      yield RegisterEmptyState();
    }
    if (event.runtimeType == UserRegister) {
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          FirebaseFirestore.instance.collection('users').add({
            'email': user.email,
            'name': event.name,
            'id': user.uid,
            'chatrooms': <String, String>{}
          });
        }

        yield UserRegisteredState(user!);
      } catch (e) {
        if (e is FirebaseAuthException) {
          yield RegisterErrorState(checkRegisterError(event,e));
        }
      }
    }
  }
  String checkRegisterError(UserRegister user,FirebaseAuthException exception) {
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
