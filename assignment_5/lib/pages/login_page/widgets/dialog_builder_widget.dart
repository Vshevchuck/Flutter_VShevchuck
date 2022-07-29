import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_page.dart';

class showMessage{
  static Route<Object?> dialogBuilderWidget(BuildContext context,
      Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(LoginPageState.message),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          ),
    );
  }
}