import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignInScreen(
      providerConfigs: [
        EmailProviderConfiguration()
      ],
    );
  }
}