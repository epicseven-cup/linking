import 'package:flutter/material.dart';

class SelectPair {
  SelectPair({required this.check, required this.index});
  bool check;
  int index;
}

class DeviceItem extends StatefulWidget {
  const DeviceItem({super.key, required this.name, required this.cb, required this.index});

  final String name;
  final ValueSetter<SelectPair> cb;
  final int index;

  @override
  State<StatefulWidget> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTileTheme(
        selectedColor: Theme.of(context).listTileTheme.selectedColor,
        selectedTileColor: Theme.of(context).listTileTheme.selectedTileColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: ListTile(
          leading: Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked =
                    value!; // it could be null so the '!' need to be in the back
              });
            },
          ),

          selected: _isChecked,
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });

            widget.cb(new SelectPair(check: _isChecked, index: widget.index));
          },

          title: Text(widget.name),
        ),
      ),
    );
  }
}
