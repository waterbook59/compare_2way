import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';

class PageTransition extends StatefulWidget {

  PageTransition({
    required this.dialogWidget,
    required this.animationController});

   Widget dialogWidget;
  AnimationController animationController;
  @override
  _PageTransitionState createState() => _PageTransitionState();
}

class _PageTransitionState extends State<PageTransition>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    widget.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: animationController dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoFullscreenDialogTransition(
      primaryRouteAnimation: widget.animationController,
      secondaryRouteAnimation: widget.animationController,
      linearTransition: false,
      child: Container(
        width: 300,
        height: 300,
        child:widget.dialogWidget,
      )

    );
  }
}

