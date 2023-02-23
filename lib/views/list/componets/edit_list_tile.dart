import 'package:flutter/material.dart';

class EditListTile extends StatelessWidget {
  const EditListTile(
      {Key? key, required this.title, required this.onTap, required this.icon,})
      : super(key: key);

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
