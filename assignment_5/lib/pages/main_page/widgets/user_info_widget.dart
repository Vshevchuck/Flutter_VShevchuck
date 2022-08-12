import 'package:flutter/cupertino.dart';

import '../../../util/text_styles/text_styles.dart';

class UserInfoWidget extends StatelessWidget {
  final String name;

  const UserInfoWidget({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Align(alignment:Alignment.centerLeft,child: Text(name, style: TextStyles.nameTextStyle,)),
        const SizedBox(height: 6)
      ],
    );
  }
}
