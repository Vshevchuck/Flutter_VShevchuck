import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrossFadeAndOpacityExample extends StatefulWidget {
  static const duration = Duration(milliseconds: 1000);
  final bool state;

  const CrossFadeAndOpacityExample({Key? key, required this.state})
      : super(key: key);

  @override
  State<CrossFadeAndOpacityExample> createState() =>
      _CrossFadeAndOpacityExampleState();
}

class _CrossFadeAndOpacityExampleState
    extends State<CrossFadeAndOpacityExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(opacity: widget.state ? 0:1,
          duration: CrossFadeAndOpacityExample.duration,
          child
          :const Icon(Icons.ac_unit_outlined,color: Colors.black,),),
        SizedBox(height: 10,),
        AnimatedCrossFade(
            firstChild: Container(width: 50, height: 50, color: Colors.green,),
            secondChild: Container(width: 150, height: 80, color: Colors.red,),
            crossFadeState:
            widget.state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: CrossFadeAndOpacityExample.duration),
      ],
    );
  }
}
