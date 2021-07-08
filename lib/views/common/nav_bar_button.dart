import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavBarButton extends StatelessWidget {

  const NavBarButton({this.navBarIcon,this.onTap});

final IconData navBarIcon;
final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Icon(
        //CupertinoIcons.keyboard_chevron_compact_downない
//        Icons.keyboard_hide,
        navBarIcon,
        color: Colors.white,
      ),
      onTap:onTap,
    );
  }
}
