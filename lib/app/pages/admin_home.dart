import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/app/pages/admin_add_article.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/snackbars.dart';
import 'package:news_app/widgets/article_list_tile.dart';

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
      body: StreamBuilder<List<Article>>(
        stream: ref.watch(databaseProvider)!.getArticles(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active
           && snapshot.data != null) {
            if(snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No articles yet...'
                    ),
                    Lottie.asset(
                      'assets/anim/empty.json',
                      repeat: false,
                      width: 200
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ArticleListTile(
                  article: article,
                  onDelete: () {
                    ref
                      .read(databaseProvider)!
                      .deleteArticle(article.id!);
                    openIconSnackBar(
                      context, 
                      'Deleted the article', 
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    );
                  },
                  onPressed: () {
                    
                  },
                );
              }
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AdminAddProductPage())
        )),
        child: const Icon(Icons.add),
      ),
    );
  }


}
