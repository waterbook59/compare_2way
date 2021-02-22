import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EvaluateDropdown extends StatefulWidget {
  EvaluateDropdown({this.initialValue,this.onSelected});

  String initialValue ;
  Function(String) onSelected;


  @override
  _EvaluateDropdownState createState() => _EvaluateDropdownState();
}

class _EvaluateDropdownState extends State<EvaluateDropdown> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton<String>(
          initialValue: widget.initialValue ,
          elevation: 0,
          icon: const Icon(Icons.arrow_drop_down),
//          iconSize: 30,
          itemBuilder:(BuildContext context )=> <PopupMenuEntry<String>>[
            PopupMenuItem(
              value: '0',
              child: Center(child: Text('-',style: TextStyle(fontSize: 40),)),
            ),
            PopupMenuItem(
              value: '1',
              child: Center(child: Text('◎',style: TextStyle(fontSize: 40),)),
            ),
            PopupMenuItem(
              value: '2',
              child: Center(child: Text('○',style: TextStyle(fontSize: 40),)),
            ),
            PopupMenuItem(
              value: '3',
              child: Center(child: Text('△',style: TextStyle(fontSize: 40),)),
            ),
            PopupMenuItem(
              value: '4',
              child: Center(child: Text('×',style: TextStyle(fontSize: 40),)),
            )
          ],
          onSelected: (newValue){
            setState(() {
              widget.onSelected(newValue);
            });
          },

        ),
      ),
    );
  }
}
