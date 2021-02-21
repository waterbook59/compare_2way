import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EvaluatePicker extends StatefulWidget {
  @override
  _EvaluatePickerState createState() => _EvaluatePickerState();
}

class _EvaluatePickerState extends State<EvaluatePicker> {

  int _changedNumber = 0, _selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CupertinoButton(
            child: Text("Select Number :"),
            onPressed: () {
              showModalBottomSheet<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200.0,
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: CupertinoPicker(
                                scrollController:
                                 FixedExtentScrollController(
                                  initialItem: _selectedNumber,
                                ),
                                itemExtent: 32.0,
                                backgroundColor: Colors.white,
                                onSelectedItemChanged: (int index) {
                                  _changedNumber = index;
                                },
                                children: new List<Widget>.generate(100,
                                        (int index) {
                                      return  Center(
                                        child:  Text('${index+1}'),
                                      );
                                    })),
                          ),
                          CupertinoButton(
                            child: Text("Ok"),
                            onPressed: () {
                              setState(() {
                                _selectedNumber = _changedNumber;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }),
        Text(
          '${_selectedNumber+1}',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );

    }
    }
