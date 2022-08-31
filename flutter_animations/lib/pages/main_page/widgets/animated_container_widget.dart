import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatelessWidget {
  static const duration = Duration(milliseconds: 1500);
  final bool state;
  final VoidCallback onEnd;
  const AnimatedContainerWidget({Key? key, required this.state,required this.onEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: state ?  Alignment.bottomLeft : Alignment.topRight,
      duration: duration,
      onEnd: onEnd,
      child: AnimatedContainer(
          duration: duration,
          alignment: state ? Alignment.centerRight : Alignment.centerLeft,
          color: state ? Colors.amber : Colors.green,
          width: state ? 100 : 50,
          height: state ? 100 : 50),
    );
  }
}
