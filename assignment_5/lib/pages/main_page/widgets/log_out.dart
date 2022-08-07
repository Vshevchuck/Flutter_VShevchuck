import 'package:assignment_5/bloc/user_bloc/user_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc/user_state.dart';
import '../../../bloc/user_bloc/users_bloc.dart';
import '../../../generated/locale_keys.g.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if(state is UserLogOutState)
      {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, '/login');});
      }
     return TextButton(
          onPressed: ()  {
            userBloc.add(UserLogOutEvent());
          },
          child: Text(style:const TextStyle(color: Colors.white), LocaleKeys.Log_Out.tr()));
    });
  }
}
