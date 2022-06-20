
import 'package:flutter/material.dart';

class ChangeHoursOrDaysWidget extends StatefulWidget {
  final Function setStateMainScreen;
  const ChangeHoursOrDaysWidget({Key? key, required this.setStateMainScreen}) : super(key: key);

  @override
  State<ChangeHoursOrDaysWidget> createState() => ChangeHoursOrDaysWidgetState();
}

class ChangeHoursOrDaysWidgetState extends State<ChangeHoursOrDaysWidget> {
  static List<String> items = ['Days', 'By the hour'];
  static String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: DropdownButtonFormField<String>(
            dropdownColor: Colors.black54,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.white,
            value: selectedItem,
            hint: const Text("Days / by the hour",
                style: TextStyle(fontSize: 17, color: Colors.white)),
            items: items
                .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item,
                  style: const TextStyle(
                      fontSize: 17, color: Colors.white)),
            ))
                .toList(),
            onChanged: (item) {
              setState(() => selectedItem = item);
              widget.setStateMainScreen();
            }),
      ),
    );
  }
}