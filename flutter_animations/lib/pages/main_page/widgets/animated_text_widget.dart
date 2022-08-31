import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  static const duration = Duration(milliseconds: 1500);
  final bool state;
  final VoidCallback onEnd;

  AnimatedTextWidget({Key? key, required this.state, required this.onEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: duration,
      style: state ? styleOne : styleTwo,
      child: state ? Text('animation') : Text('project'),
    );
  }

  TextStyle styleOne =
      const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600,fontSize: 20);

  TextStyle styleTwo = const TextStyle(color: Colors.red, fontSize: 40);
}
