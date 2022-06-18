import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/app/pages/admin_add_article.dart';
import 'package:news_app/app/pages/admin_edit_article.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/snackbars.dart';
import 'package:news_app/widgets/article_list_tile.dart';
import 'package:news_app/widgets/empty_widget.dart';

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
              return const EmptyWidget();
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Article article = snapshot.data![index];
                return ArticleListTile(
                  article: article,
                  onDelete: () {
                    ref
                      .read(databaseProvider)!
                      .deleteArticle(article.id!);
                    ref
                      .read(storageProvider)!
                      .deleteImage(article.imageUrl!);
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdminEditArticlePage(
                          article: article,
                        ),
                      )
                    );
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
          MaterialPageRoute(builder: (context) => const AdminAddArticlePage())
        )),
        child: const Icon(Icons.add),
      ),
    );
  }


}
