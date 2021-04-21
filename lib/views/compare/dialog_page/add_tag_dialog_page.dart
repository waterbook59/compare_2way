import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTagDialogPage extends StatefulWidget {
  @override
  _AddTagDialogPageState createState() => _AddTagDialogPageState();
}

class _AddTagDialogPageState extends State<AddTagDialogPage>
    with TickerProviderStateMixin{

  AnimationController _primary, _secondary;
  Animation<double> _animationPrimary, _animationSecondary;

//  @override
//  void initState() {
//    //Primary
//    _primary = AnimationController(vsync: this, duration: Duration(seconds: 1));
//    _animationPrimary = Tween<double>(begin: 0, end: 1)
//        .animate(CurvedAnimation(parent: _primary, curve: Curves.easeOut));
//    //Secondary
//    _secondary =
//        AnimationController(vsync: this, duration: Duration(seconds: 1));
//    _animationSecondary = Tween<double>(begin: 0, end: 1)
//        .animate(CurvedAnimation(parent: _secondary, curve: Curves.easeOut));
//    _primary.forward();
//    super.initState();
//  }

//  @override
//  void dispose() {
//    _primary.dispose();
//    _secondary.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
//    final primaryColor = Theme.of(context).primaryColor;

    return
//      CupertinoFullscreenDialogTransition(
//      primaryRouteAnimation: _animationPrimary,
//      secondaryRouteAnimation: _animationSecondary,
//      linearTransition: false,
//      //CupertinoPageScaffoldの場合,child入れてbuildしないとエラー出る
//      child:
      CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: const Color(0xFF363A44),
            middle:const Text('タグの追加・編集'),
            leading: CupertinoButton(
              child:const Text('キャンセル'),
              onPressed:  () {
//                _primary.reverse();
//                Future.delayed(Duration(seconds: 1), () {
                  Navigator.of(context).pop();
//                });
              },
            ),
            trailing: CupertinoButton(
              child:const Text('完了'),
              onPressed: (){
                print('タグ編集完了してCompareScreenに戻る');
//                _primary.reverse();
//                Future.delayed(Duration(seconds: 1), () {
                  Navigator.of(context).pop();
//                });
              },
            )
        ),
        child: Scaffold(
          body:  Container(child: const Text('タグを修正'),),
        ),


      );

//      child: Scaffold(
//        appBar: AppBar(
//          backgroundColor: const Color(0xFF363A44),
//          title: const Text('タグの追加・編集'),
//          leading: FlatButton(
//            child:const Text('キャンセル'),
//            onPressed:  () {
//              _primary.reverse();
//              Future.delayed(Duration(seconds: 1), () {
//                Navigator.of(context).pop();
//              });
//            },
//          ),
//          actions: [
//            FlatButton(
//              child:const Text('完了'),
//              onPressed:  () {
//                print('タグ編集完了してCompareScreenに戻る');
//                _primary.reverse();
//                Future.delayed(Duration(seconds: 1), () {
//                  Navigator.of(context).pop();
//                });
//              },
//            ),
//          ],
//
//        ),
//        ),

//    );
  }
}
