import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EvaluateDropdown extends StatefulWidget {
  @override
  _EvaluateDropdownState createState() => _EvaluateDropdownState();
}

class _EvaluateDropdownState extends State<EvaluateDropdown> {

  String _selectedValue ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButton<String>(
        value: _selectedValue ,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 30,
        items: const [
          DropdownMenuItem(
            value: '1',
            child: Text('◎',style: TextStyle(fontSize: 40),),
          ),
          DropdownMenuItem(
            value: '2',
            child: Text('○',style: TextStyle(fontSize: 40),),
          ),
          DropdownMenuItem(
            value: '3',
            child: Text('△',style: TextStyle(fontSize: 40),),
          ),
          DropdownMenuItem(
            value: '4',
            child: Text('✖️',style: TextStyle(fontSize: 40),),
          )
        ],
        onChanged: (newValue){
          setState(() {
            _selectedValue = newValue;
          });
        },
        hint:const Text('-'),

      ),
    );
  }
}
