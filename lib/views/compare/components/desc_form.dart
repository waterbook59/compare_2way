import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DescForm extends StatefulWidget {
  const DescForm(
      {
//        this.items,
      this.inputChanged,
      this.index,
      this.controllers,
      this.deleteList});

//  final List<Way1Merit> items;
  final Function(String) inputChanged;
  final Function(int) deleteList;
  final int index;
  final List<TextEditingController> controllers;

  @override
  _DescFormState createState() => _DescFormState();
}

class _DescFormState extends State<DescForm> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      //material
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
        decoration: const InputDecoration(hintText: 'メリットを入力してください',),
          controller: widget.controllers[widget.index],
          onChanged: (newDesc) => widget.inputChanged(newDesc),
          style: const TextStyle(color: Colors.black),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          //ここではvoidCallbackでindexのみ渡して具体的なロジックはDescFormAndButtonで
          onPressed: () =>widget.deleteList(widget.index),
        )
      ],
    );
  }

}
