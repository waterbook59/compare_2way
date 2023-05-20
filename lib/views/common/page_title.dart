import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {

  const PageTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children:  [
        const SizedBox(height: 16,),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title, textAlign: TextAlign.left,),
        ),
        const SizedBox(height: 4,),
      ],
    );


  }
}
