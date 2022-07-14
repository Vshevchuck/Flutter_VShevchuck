import 'package:assignment_5/bloc/login_state.dart';
import 'package:assignment_5/bloc/register_state.dart';
import 'package:assignment_5/bloc/user_provider.dart';
import 'package:assignment_5/bloc/user_state.dart';
import 'package:assignment_5/pages/login_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<dynamic, UserState> {
  List<UserModel> users = <UserModel>[];

  @override
  get initialState => UserLoadingState();



  @override
  Stream<UserState> mapEventToState(dynamic event) async* {
    if (event==true) {
      FirebaseFirestore.instance.collection('users').snapshots().listen((
          snapshot) {
        add(snapshot.docs);
      });}
      if (event != null) {
        try {
          for (int i = 0; i < event.length; i++) {
            UserModel user = UserModel.fromJson(event[i].data());
            users.add(user);
          }
          yield UserLoadedState(users);
        } catch (_) {}
      }
    }
  }
