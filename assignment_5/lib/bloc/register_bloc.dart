import 'package:assignment_5/bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';



class RegisterBloc extends Bloc<UserRegister, RegisterState> {
  UserRegister userRegister=UserRegister('Empty', 'Empty', 'Empty');

  @override
  get initialState => RegisterEmptyState();

  @override
  Stream<RegisterState> mapEventToState(UserRegister event) async* {
    if (event.email!="Empty") {
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        user = FirebaseAuth.instance.currentUser;
        yield UserRegisteredState(user!);
      } catch (_) {}
    }
  }
}
