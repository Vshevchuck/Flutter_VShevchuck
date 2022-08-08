import 'package:flutter/cupertino.dart';

import '../../../util/text_styles/text_styles.dart';

class UserInfoWidget extends StatelessWidget {
  final String name;
  final String email;

  const UserInfoWidget({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: TextStyles.nameTextStyle,),
        Text(email, style: TextStyles.emailTextStyle),
        const SizedBox(height: 6)
      ],
    );
  }
}
