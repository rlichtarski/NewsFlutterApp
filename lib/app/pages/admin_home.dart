import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => ref.read(firebaseAuthProvider).signOut(),
        ),
      ),
    );
  }


}
