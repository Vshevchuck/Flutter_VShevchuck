import 'package:assignment_5/bloc/user_bloc/user_event.dart';
import 'package:assignment_5/models/user_model.dart';
import 'package:assignment_5/pages/main_page/widgets/user_info_widget.dart';
import 'package:assignment_5/util/colors/colors_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc/user_state.dart';
import '../../../bloc/user_bloc/users_bloc.dart';
import '../../../util/text_styles/text_styles.dart';

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
                  color: index.isEven
                      ? ColorStyle.EvenBorderColor
                      : ColorStyle.NotEvenBorderColor,
                ),
                child: ListTile(
                  tileColor: index.isEven
                      ? ColorStyle.EvenUserColor
                      : ColorStyle.NotEvenUserColor,
                  onTap: () {
                    Navigator.of(context).pushNamed('/chatroom', arguments: [
                      state.loadedUsers[index].first as UserModel,
                      dataUser
                    ]);
                  },
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: index.isEven
                            ? ColorStyle.EvenAvatarColor
                            : ColorStyle.NotEvenAvatarColor,
                      ),
                      child: Center(
                          child: Text(
                        state.loadedUsers[index].first.name[0],
                        style: TextStyles.firstLetterOfNameTextStyle,
                      ))),
                  title: UserInfoWidget(
                    name: state.loadedUsers[index].first.name,
                    email: state.loadedUsers[index].first.email,
                  ),
                  subtitle: Text(
                    state.loadedUsers[index][1],
                    maxLines: 1,
                  ),
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
