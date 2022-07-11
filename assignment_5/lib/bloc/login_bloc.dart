import 'package:assignment_5/bloc/login_state.dart';
import 'package:assignment_5/bloc/register_state.dart';
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
      } catch (_) {}
    }
  }
}
