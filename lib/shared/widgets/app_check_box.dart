import 'package:flutter/material.dart';

import '../shared.dart';

class AppCheckbox extends StatefulWidget {
  final String? label;
  final bool? checked;
  final Function(bool?)? onChecked;

  const AppCheckbox({super.key, this.label, this.checked, this.onChecked});

  @override
  AppCheckboxState createState() => AppCheckboxState();
}

class AppCheckboxState extends State<AppCheckbox> {
  bool? _checked = false;

  void _onChecked(bool? checked) {
    debugPrint(checked as String?);
    setState(() {
      _checked = checked;
    });

    if (widget.onChecked != null) {
      widget.onChecked!(checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
                value: _checked,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: _onChecked),
          ),
          CommonWidget.rowWidth(width: 10.0),
          Flexible(
            child: Text(
              widget.label!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
