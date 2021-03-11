import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {

  const MyCustomForm({this.conclusion,this.onSaved});
  final String conclusion;
  final Function(String) onSaved;

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  ///ここにGlobalKeyがあることが重要
  final _formKey = GlobalKey<FormState>();
  var _conclusion ='';

  @override
  Widget build(BuildContext context) {
    return   Form(
        key: _formKey,
        child: Column(
        children: <Widget>[
          TextFormField(
            //initialValueとcontrollerの両方は使用できない
          initialValue: widget.conclusion,
//            controller: _conclusionController,
//          onChanged: widget.inputChanged,
//          onEditingComplete: () {
//            widget.onEditingCompleted(_conclusionController.text);
//          },
            onSaved: (newValue){
            _conclusion = newValue;
            },

            ///onFiledSubmittedはdoneボタン時
//        onFieldSubmitted: widget.onFieldSubmitted,
            ///onSaved+key設定でFormの内容保存できる？
            minLines: 6,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

        RaisedButton(
          child: const Text('テストSaved'),
          onPressed: (){
          _formKey.currentState.save();
          print('結論：$_conclusion');
          },
        )
        ]
        ),
    );
  }
}
