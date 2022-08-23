import 'dart:async';

import 'package:assignment_5/pages/login_page/widgets/dialog_builder_widget.dart';
import 'package:assignment_5/pages/register_page/register_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/register_bloc/register_bloc.dart';
import '../../../bloc/register_bloc/register_event.dart';
import '../../../bloc/register_bloc/register_state.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../models/user_model.dart';
import '../../../util/decorations/decorations.dart';
import '../../login_page/login_page.dart';

class ButtonRegisterWidget extends StatelessWidget {
  const ButtonRegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is UserRegisteredState) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushReplacementNamed('/main', arguments: state.user);
          });
        }
        if (state is RegisterErrorState) {
          registerBloc.add(SetInitialRegisterEvent());
          LoginPageState.message = state.message;
          scheduleMicrotask(() => {
                Navigator.of(context)
                    .restorablePush(ShowMessage.dialogBuilderWidget)
              });
        }
        return Container(
            decoration: Decorations.buttonDecoration,
            child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      UserRegister userModel = UserRegister(
                          RegisterPage.nameController.text,
                          RegisterPage.emailController.text,
                          RegisterPage.passwordController.text);
                      registerBloc.add(GetUserDataEvent(userModel));
                      RegisterPage.emailController.text = "";
                      RegisterPage.passwordController.text = "";
                      RegisterPage.nameController.text = "";
                    },
                    child: Text(LocaleKeys.Sign_Up.tr()))));
      },
    );
  }
}
