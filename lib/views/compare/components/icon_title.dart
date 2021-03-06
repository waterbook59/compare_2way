
import 'package:flutter/cupertino.dart';

class IconTitle extends StatelessWidget {
 const  IconTitle({this.title,this.iconData, this.iconColor});
  final String title;
  final Color iconColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Icon(iconData,color: iconColor,),
        const SizedBox(width: 4),
        Text(title),
      ]),
    );
  }
}

