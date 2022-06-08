import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String body;

  const CardWidget({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
          color: Colors.grey[300],
          child: Column(
            children: [
              Container(
                  height: 20,
                  child: Text('$title',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500))),
              const SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                      width: 1.0,
                      color: Colors.brown.shade200,
                    )),
                  ),
                  child:
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(body, style: const TextStyle(color: Colors.black)),
                      ))
            ],
          )),
    );
  }
}
