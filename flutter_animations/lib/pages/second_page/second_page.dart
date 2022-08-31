import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/second_page/widgets/animated_cross_fade.dart';
import 'package:flutter_animations/pages/second_page/widgets/rotation_example.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static bool state = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = !state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.near_me)),
          IconButton(
              onPressed: () {
                setState(() {
                  state = !state;
                });
              },
              icon: const Icon(
                Icons.start,
                color: Colors.deepPurple,
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: RotationExample(state: state)),
          const SizedBox(height: 10),
          CrossFadeAndOpacityExample(state: state),
        ],
      ),
    );
  }
}
