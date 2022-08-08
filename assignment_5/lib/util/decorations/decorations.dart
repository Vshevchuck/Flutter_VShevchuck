import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Decorations{
  static final buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  gradient: const LinearGradient(
  begin: Alignment(-0.95, 0.0),
  end: Alignment(1.0, 0.0),
  colors: [Color(0xff667eea), Color(0xff64b6ff)],
  stops: [0.0, 1.0],
  ));
  static const backgroundChatRoomDecoration =  BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigoAccent, Colors.white,Colors.white])
  );
}