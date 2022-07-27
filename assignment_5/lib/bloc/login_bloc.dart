import 'package:assignment_5/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';

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
      } catch (_) {
        yield LoginErrorState(checkLoginError(event));
      }
    }
  }
  String checkLoginError(UserLogin user)
  {
    bool checkError = false;
    if (user.email.isEmpty || user.password.isEmpty) {
      checkError = true;
      return('Fill in all the fields');
    }
    if (user.password.length < 6) {
      checkError = true;
      return('password must be at least 6 characters');
    }
    if (!user.email.contains('.') || !user.email.contains('@')) {
      checkError = true;
      return(
          'invalid email input form , please check availability . or @');
    }
    if (!checkError) {
      return("something went wrong, please login again");
    }
  }
}
