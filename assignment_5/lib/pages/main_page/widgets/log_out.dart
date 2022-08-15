import 'package:assignment_5/bloc/user_bloc/user_event.dart';
import 'package:assignment_5/util/colors/colors_style.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLogOutState) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: TextButton(
        onPressed: () {
          userBloc.add(UserLogOutEvent());
        },
        child: Text(
          style: const TextStyle(color: ColorStyle.LogOutButtonColor),
          LocaleKeys.Log_Out.tr(),
        ),
      ),
    );
  }
}
