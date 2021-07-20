import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EditListTile extends StatelessWidget {

  const EditListTile({this.title,this.onTap,this.icon});

  final String title;
  final VoidCallback onTap;
//  final Widget icon;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(title),
    );
  }
}
