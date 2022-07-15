import 'package:assignment_5/bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class ChatRoomBloc extends Bloc<dynamic, RegisterState> {

  @override
  get initialState => RegisterEmptyState();

  @override
  Stream<RegisterState> mapEventToState(dynamic event) async* {


  }
}
