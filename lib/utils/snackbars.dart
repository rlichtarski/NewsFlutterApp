import 'package:flutter/material.dart';

openIconSnackBar(context, String text, Widget icon) {
  ScaffoldMessenger.of(context)
  ..removeCurrentSnackBar()
  ..showSnackBar( 
    SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          icon,
          const SizedBox(width: 5,),
          Text(text)
        ],
      ),
      duration: const Duration(milliseconds: 2500),
    )
  );
}
