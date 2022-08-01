import 'dart:math';
import 'package:assignment_5/generated/locale_keys.g.dart';
import 'package:assignment_5/pages/main_page/widgets/card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc/users_bloc.dart';

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
            Expanded(child: Text('${dataUser.email}')),
            ElevatedButton(
                onPressed: () {
                  setState((){});
                },
                child: Text(LocaleKeys.Update.tr())),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login',
                      arguments: true);
                },
                child: Text(LocaleKeys.Log_Out.tr()))
          ],
        )),
        body: CardWidget(
          dataUser: dataUser,
        ),
      )),
    );
  }
}

