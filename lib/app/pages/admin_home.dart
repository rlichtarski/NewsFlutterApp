import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/pages/admin_add_article.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';

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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => ref.read(databaseProvider)!.deleteArticle(article.id!),
                  ),
                  title: Text(article.title),
                  subtitle: Text(article.description),
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
