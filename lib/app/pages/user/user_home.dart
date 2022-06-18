import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/widgets/display_articles.dart';
import 'package:news_app/widgets/main_article.dart';
import 'package:news_app/widgets/user_top_bar.dart';

class UserHome extends ConsumerWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //backgroundColor: const Color(0xFFFBFBFF),
      backgroundColor: Color.fromARGB(232, 251, 252, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserTopBar(leadingIconButton: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              ),),
              const SizedBox(height: 20,),
              const Text(
                'Your daily read',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10,),
              const Flexible(child: DisplayArticles())
            ],
          ),
        )
      ),
    );
  }
}
