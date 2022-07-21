import 'dart:math';

import 'package:assignment_5/bloc/user_provider.dart';
import 'package:assignment_5/pages/chat_room/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_state.dart';
import '../../bloc/users_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final dataUser = (ModalRoute.of(context)?.settings.arguments) as User;
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Text('${dataUser.email}'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login',
                      arguments: true);
                },
                child: Text('Log out'))
          ],
        )),
        body: CardWidget(
          dataUser: dataUser,
        ),
        //body: StreamBuilder(
        //stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //builder:
        // (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //if (!snapshot.hasData) {
        //return const Center(child: Text("No elements"));
        //} else {
        //userBloc.add(snapshot.data!.docs);
        //print(snapshot.data!.docs.toList());
        //}
        //}
        //),
      )),
    );
  }
}

class CardWidget extends StatelessWidget {
  final User dataUser;

  const CardWidget({Key? key, required this.dataUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(true); // init ?
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadedState) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.loadedUsers.length,
          itemBuilder: (context, index) {
            print(state.loadedUsers[index].email);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/chatroom',
                      arguments: [state.loadedUsers[index], dataUser]);
                },
                leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color:
                          Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                              .withOpacity(1.0),
                    ),
                    child: Center(
                        child: Text(
                      state.loadedUsers[index].name[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ))),
                title: Column(
                  children: [
                    Text(
                      state.loadedUsers[index].name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(state.loadedUsers[index].email,
                        style: const TextStyle(fontStyle: FontStyle.italic))
                  ],
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
