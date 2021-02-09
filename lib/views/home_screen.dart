import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ///Theme使う場合はconst入れない
    final primaryColor = CupertinoTheme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;
    final regularTextStyle =  CupertinoTheme.of(context).textTheme.textStyle;

    return CupertinoPageScaffold(
      navigationBar:
       CupertinoNavigationBar(
        //todo TextStyleやColorはutilsにまとめる
        backgroundColor: primaryColor,
        middle:const  Text('Compare List',
          style:middleTextStyle,

        ),
        trailing:const  Text('編集',
            style:trailingTextStyle,
        ),
      ),

      ///SafeAreaはCupertinoPageScaffoldの中で
      ///さらにFABをおくならScaffoldを配置
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          body:
                    Column(
                      children:  [
                        const SizedBox(height: 20),
                       Text(
                          'Cupertino!!!',
                        style: regularTextStyle ,),
                        const SizedBox(height: 20),
                        CupertinoTextField(
                          keyboardType: TextInputType.text,
                        controller: TextEditingController(),),
                        const SizedBox(height: 20),
                        Text('テキストスタイルの変更確認',
                        style:regularTextStyle
                        ),

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
