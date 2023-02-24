import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {

  const NavBarButton({Key? key, this.navBarIcon,this.onTap}) : super(key: key);

final IconData? navBarIcon;
final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap,
      child: Icon(
        //CupertinoIcons.keyboard_chevron_compact_downない
//        Icons.keyboard_hide,
        navBarIcon,
        color: Colors.white,
      ),
    );
  }
}
