import 'package:flutter/material.dart';

import '../../../util/colors/colors_style.dart';
import '../../../util/text_styles/text_styles.dart';

class ChangeHoursOrDaysWidget extends StatefulWidget {
  final Function setStateMainScreen;

  const ChangeHoursOrDaysWidget({Key? key, required this.setStateMainScreen})
      : super(key: key);

  @override
  State<ChangeHoursOrDaysWidget> createState() =>
      ChangeHoursOrDaysWidgetState();
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
            dropdownColor: ColorStyle.dropDownColor,
            iconEnabledColor:  ColorStyle.iconEnabledColor,
            iconDisabledColor: ColorStyle.iconDisabledColor,
            value: selectedItem,
            hint: const Text("Days / by the hour",
                style: TextStyles.dropdownButtonTitleTextStyle),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: TextStyles.dropdownButtonElementTextStyle ),
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
