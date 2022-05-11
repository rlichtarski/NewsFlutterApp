import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/utils/constants.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.signedInBuilder,
    required this.nonSignedInBuilder,
    required this.adminPanelBuilder,
  }) : super(key: key);

  final WidgetBuilder signedInBuilder;
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder adminPanelBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) => user != null 
        ? user.email == adminEmail ? adminPanelBuilder(context) : signedInBuilder(context) 
      : nonSignedInBuilder(context), 
      error: (_, __) => const Center(child: Text('Something went wrong'),), 
      loading: () => const Center(child: CircularProgressIndicator(),)
    );
  }

}
