import 'package:assignment_5/bloc/login_bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../user_bloc/user_state.dart';

class LoginBloc extends Bloc<dynamic, LoginState> {
  UserLogin userLogin = UserLogin('Empty', 'Empty');

  @override
  get initialState => LoginEmptyState();

  @override
  Stream<LoginState> mapEventToState(dynamic event) async* {
    if (event.runtimeType == String) {
      yield LoginEmptyState();
    }
    if (event.runtimeType == UserLogin) {
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        user = FirebaseAuth.instance.currentUser;
        yield UserLoginedState(user!);
      } catch (e) {
        if (e is FirebaseAuthException) {
          yield LoginErrorState(checkLoginError(event,e));
        }
      }
    }
  }

  String checkLoginError(UserLogin user,FirebaseAuthException e) {
    if (user.email.isEmpty || user.password.isEmpty) {
      return ('Fill in all the fields');
    }
    if (user.password.length < 6) {
      return ('password must be at least 6 characters');
    }
    if (!user.email.contains('.') || !user.email.contains('@')) {
      return ('invalid email input form , please check availability . or @');
    }
    return(e.message.toString());
  }
}
