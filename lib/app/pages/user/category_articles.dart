import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/displayed_user_article_tile.dart';
import 'package:news_app/widgets/empty_widget.dart';

class CategoryArticles extends ConsumerWidget {
  const CategoryArticles({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(Icons.arrow_back)
                  ),
                  Flexible(
                    child: Text(
                      '$category Articles',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: StreamBuilder(
                  stream: ref.read(databaseProvider)!.getArticlesByCategory(category),
                  builder: (context, AsyncSnapshot<List<Article>> snapshot) {
                    if(snapshot.data == null) {
                      return const EmptyWidget(text: 'No articles in this category...');
                    }
                    if(snapshot.data!.isEmpty) {
                      return const EmptyWidget(text: 'No articles in this category...');
                    }
                    switch(snapshot.connectionState) {
                      case ConnectionState.active: {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            final article = snapshot.data![index];
                            return DisplayedUserArticleListTile(article: article);
                          })
                        );
                      }
                      case ConnectionState.waiting: {
                         if(snapshot.data == null) {
                            return const EmptyWidget(text: 'No articles in this category...');
                          }
                          if(snapshot.data!.isEmpty) {
                            return const EmptyWidget(text: 'No articles in this category...');
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                      case ConnectionState.done: {
                        return const Center(
                          child: Text('Done')
                        );
                      }
                      case ConnectionState.none: {
                        return const Center(
                          child: Text('No articles in this category...'),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
