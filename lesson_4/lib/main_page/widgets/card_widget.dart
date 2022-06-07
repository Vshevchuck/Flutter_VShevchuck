import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String body;

  const CardWidget({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[800],
        child: Column(
          children: [
            Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 1.0,
                    color: Colors.brown.shade200,
                  )),
                ),
                child: Text('Title: $title',
                    style: const TextStyle(color: Colors.white))),
            SizedBox(
                width: 100,
                height: 70,
                child: Text(body, style: const TextStyle(color: Colors.white)))
          ],
        ));
  }
}
