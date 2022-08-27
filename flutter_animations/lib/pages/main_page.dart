import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/widgets/animated_container_widget.dart';
import 'package:flutter_animations/pages/widgets/animated_text_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool state = true;

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
        floatingActionButton: IconButton(
            onPressed: () {
              setState(() {
                state = !state;
              });
            },
            icon: const Icon(
              Icons.start,
              color: Colors.deepPurple,
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextWidget(
              state: state,
              onEnd: () {
                setState(() {
                  state = !state;
                });
              },
            ),
            SizedBox(height: 30),
            AnimatedContainerWidget(
              state: state,
              onEnd: () {
                setState(() {
                  state = !state;
                });
              },
            ),
          ],
        ));
  }
}
