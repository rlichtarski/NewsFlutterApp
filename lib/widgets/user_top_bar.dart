import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  const UserTopBar({
    Key? key, 
    required this.leadingIconButton,
    required this.bookmarkIconButton,
  }) : super(key: key);

  final IconButton leadingIconButton;
  final IconButton bookmarkIconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        bookmarkIconButton
      ],

    );
  }
}
