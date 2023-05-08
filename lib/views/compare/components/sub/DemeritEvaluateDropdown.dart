import 'package:flutter/material.dart';

class DemeritEvaluateDropdown extends StatefulWidget {
  const DemeritEvaluateDropdown(
      {Key? key, required this.initialValue, required this.onSelected,})
      : super(key: key);

  final int initialValue;

  final void Function(int) onSelected;

  @override
  State<DemeritEvaluateDropdown> createState() => _EvaluateDropdownState();
// _EvaluateDropdownState createState() => _EvaluateDropdownState();
}

class _EvaluateDropdownState extends State<DemeritEvaluateDropdown> {
  int displayValue = 0;

  @override
  void initState() {
    displayValue = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    /// //todo:  displayValueインスタンス？
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton<int>(
          initialValue: displayValue,
          elevation: 0,
          icon: const Icon(Icons.arrow_drop_down),
//          iconSize: 30,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            const PopupMenuItem(
              value: 0,
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(fontSize: 40),
                ),),
            ),
            const PopupMenuItem(
              value: 1,
              child: Center(
                child: Text(
                  '△',
                  style: TextStyle(fontSize: 40),
                ),),
            ),
            PopupMenuItem(
              value: 2,
              child: Center(
                child: Image.asset(
                  'assets/images/cross.png',
                  width: 48,
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Center(
                child: Image.asset(
                  'assets/images/double_cross.png',
                  width: 48,
                ),
              ),
            )
          ],
          onSelected: (newValue) {
            setState(() {
              displayValue = newValue;
              widget.onSelected(newValue);
            });
          },
        ),
      ),
    );
  }
}
