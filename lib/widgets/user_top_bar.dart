
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserTopBar extends StatelessWidget {
  const UserTopBar({Key? key, required this.leadingIconButton}) : super(key: key);

  final IconButton leadingIconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag)),
      ],

    );
  }
}
