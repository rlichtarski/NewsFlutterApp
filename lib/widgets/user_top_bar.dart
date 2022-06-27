import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  const UserTopBar({
    Key? key, 
    required this.leadingIconButton,
    this.menuIconButton,
    required this.bookmarkIconButton,
  }) : super(key: key);

  final IconButton leadingIconButton;
  final IconButton? menuIconButton;
  final IconButton bookmarkIconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingIconButton,
        const Spacer(),
        menuIconButton ?? const SizedBox(),
        bookmarkIconButton 
      ],

    );
  }
}
