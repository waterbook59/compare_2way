import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
      const CupertinoNavigationBar(
        //todo ThemeDataの使い方
        //todo TextStyleやColorはutilsにまとめる
        backgroundColor: const Color(0xFF363A44),
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

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
          onPressed: ()=>print('押したぜFAB'),),
        ),

      ),
    );
  }
}
