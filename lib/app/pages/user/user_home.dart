import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/pages/categories_page.dart';
import 'package:news_app/app/pages/user/saved_articles_page.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/widgets/display_articles.dart';
import 'package:news_app/widgets/main_article.dart';
import 'package:news_app/widgets/user_top_bar.dart';

class UserHome extends ConsumerWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 251, 252, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserTopBar(
                leadingIconButton: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => ref.read(firebaseAuthProvider).signOut(),
                ),
                menuIconButton: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CategoriesPage())
                    );
                  },
                ),
                bookmarkIconButton: IconButton(
                  icon: const Icon(Icons.bookmarks),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SavedArticles()
                      )
                    );
                  },
                ),
              ),
              const SizedBox(height: 20,),
              const Flexible(child: DisplayArticles())
            ],
          ),
        )
      ),
    );
  }
}
