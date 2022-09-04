import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  double _sliderValue = 0;
  Color _newColor=Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TweenAnimationBuilder(
              duration: const Duration(seconds: 2),
              tween: ColorTween(begin: Colors.white, end: _newColor),
              builder: (BuildContext context, Color? color, __) {
                return ColorFiltered(
                    colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                    child: Image.asset('assets/07149r (1).jpg'));
              },
            ),
            Slider.adaptive(
                value: _sliderValue,
                onChanged: (double value) {
                  setState(() {
                    _sliderValue = value;
                    _newColor = Color.lerp(Colors.white, Colors.grey, _sliderValue)!;
                  });
                })
          ],
        ),
      ),
    );
  }
}
