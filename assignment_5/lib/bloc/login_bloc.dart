import 'package:assignment_5/bloc/login_state.dart';
import 'package:assignment_5/bloc/register_state.dart';
import 'package:assignment_5/bloc/user_state.dart';
import 'package:assignment_5/pages/login_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';

class LoginBloc extends Bloc<UserLogin, LoginState> {
  UserLogin userLogin = UserLogin('Empty', 'Empty');

  @override
  get initialState => LoginEmptyState();

  @override
  Stream<LoginState> mapEventToState(UserLogin event) async* {
    if (event.email != "Empty") {
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        user = FirebaseAuth.instance.currentUser;
        yield UserLoginedState(user!);
      } catch (_) {
        bool checkError = false;
        if (!event.email.contains('.') || !event.email.contains('@')) {
          checkError = true;
          yield LoginErrorState(
              'invalid email input form , please check availability . or @');
        }
        if (event.password.length < 6) {
          checkError = true;
          yield LoginErrorState('password must be at least 6 characters');
        }
        if (event.email.isEmpty || event.password.isEmpty) {
          checkError = true;
          yield LoginErrorState('Fill in all the fields');
        }
        if (!checkError) {
          yield LoginErrorState("something went wrong, please login again");
        }
      }
    }
  }
}
