import 'dart:math';

import 'package:assignment_5/bloc/user_bloc/user_event.dart';
import 'package:assignment_5/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc/user_state.dart';
import '../../../bloc/user_bloc/users_bloc.dart';

class CardWidget extends StatelessWidget {
  final User dataUser;

  const CardWidget({Key? key, required this.dataUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(UserLoadingEvent(dataUser.uid));
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadedState) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.loadedUsers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: index.isEven ? Colors.blue[50] : Colors.white54,
                ),
                child: ListTile(
                  tileColor: index.isEven ? Colors.amber[50] : Colors.white,
                  onTap: () {
                    Navigator.of(context).pushNamed('/chatroom',
                        arguments: [state.loadedUsers[index][0] as UserModel , dataUser]);
                  },
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: Color(
                                (Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                            .withOpacity(1.0),
                      ),
                      child: Center(
                          child: Text(
                        state.loadedUsers[index][0].name[0],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ))),
                  title: Column(
                    children: [
                      Text(
                        state.loadedUsers[index].first.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(state.loadedUsers[index].first.email,
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                  subtitle: Text(state.loadedUsers[index][1],
                      style: const TextStyle(fontStyle: FontStyle.italic)),
                ),
              )),
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
