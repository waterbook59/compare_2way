import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final primaryColor = CupertinoTheme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

    return CupertinoPageScaffold(
      navigationBar:
       CupertinoNavigationBar(
        //todo ThemeDataの使い方
        //todo TextStyleやColorはutilsにまとめる
        backgroundColor: primaryColor,
        middle: Text('Compare List',
            style: TextStyle(
              color: Colors.white,fontSize: 18
            )),
        trailing: Text('編集',style: TextStyle(
          color: Colors.white,
        )),
      ),

      ///SafeAreaはCupertinoPageScaffoldの中で
      ///さらにFABをおくならScaffoldを配置
      child: SafeArea(
        child: Scaffold(
          body:
                    Column(
                      children:  [
                        const SizedBox(height: 20),
                        const Text('Cupertino!!!'),
                        const SizedBox(height: 20),
                        CupertinoTextField(
                          keyboardType: TextInputType.text,
                        controller: TextEditingController(),),

          ],
        ),

          floatingActionButton: SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              backgroundColor:accentColor,
//              const Color(0xFFFF7043),
              child:  Icon(
                Icons.add,
                color: const Color(0xFF000000),
                size:40
              ),
            onPressed: ()=>print('押したぜFAB'),),
          ),
        ),


      ),
    );
  }
}
