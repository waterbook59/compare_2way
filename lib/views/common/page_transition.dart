import 'package:flutter/cupertino.dart';

class PageTransition extends StatefulWidget {

  PageTransition({Key? key,
    required this.dialogWidget,
    required this.animationController,}) : super(key: key);

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
      duration: const Duration(milliseconds: 500),
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
      child: SizedBox(
        width: 300,
        height: 300,
        child:widget.dialogWidget,
      )

    ,);
  }
}
