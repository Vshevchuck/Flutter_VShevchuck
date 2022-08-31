import 'dart:math';

import 'package:flutter/material.dart';

class RotationExample extends StatelessWidget {
  static const duration = Duration(milliseconds: 1000);
  final bool state;

  const RotationExample({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: state ? 0 : pi,
      duration: duration,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blueAccent,
      ),
    );
  }
}
