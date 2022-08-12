import 'package:assignment_5/pages/main_page/widgets/card_widget.dart';
import 'package:assignment_5/pages/main_page/widgets/log_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc/users_bloc.dart';
import '../../util/decorations/decorations.dart';

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
            const LogOut(),
          ],
        )),
        body: Container(
          height: double.maxFinite,
          decoration: Decorations.backgroundMainDecoration,
          child: CardWidget(
            dataUser: dataUser,
          ),
        ),
      )),
    );
  }
}
