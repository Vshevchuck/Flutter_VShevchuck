import 'package:assignment_5/bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

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
      } catch (_) {
        bool checkError = false;
        if (!event.email.contains('.') || !event.email.contains('@')) {
          checkError = true;
          yield RegisterErrorState(
              'invalid email input form , please check availability . or @');
        }
        if (event.password.length < 6) {
          checkError = true;
          yield RegisterErrorState('password must be at least 6 characters');
        }
        if (event.email.isEmpty ||
            event.password.isEmpty ||
            event.name.isEmpty) {
          checkError = true;
          yield RegisterErrorState('Fill in all the fields');
        }
        if (!checkError) {
          yield RegisterErrorState("something went wrong, please login again");
        }
      }
    }
  }
}
