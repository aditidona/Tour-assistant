import 'package:flutter/material.dart';

class Actionchip extends StatefulWidget {
  final String chipName;
  final Map choices;
  const Actionchip({Key? key, required this.chipName, required this.choices})
      : super(key: key);

  @override
  _ActionchipState createState() => _ActionchipState();
}

class _ActionchipState extends State<Actionchip> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(widget.chipName),
      //avatar: _isSelected ? Icon(Icons.check, color: Colors.black) : null,
      labelStyle: _isSelected
          ? TextStyle(color: Colors.black)
          : TextStyle(color: Colors.white),
      backgroundColor: _isSelected
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).backgroundColor,
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.choices[widget.chipName.toLowerCase()] = _isSelected;
        });
      },
    );
  }
}
