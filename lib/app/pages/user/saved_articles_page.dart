import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/snackbars.dart';
import 'package:news_app/widgets/empty_widget.dart';
import 'package:news_app/widgets/saved_article_list_tile.dart';

class SavedArticles extends ConsumerWidget {
  const SavedArticles({Key? key}) : super(key: key);

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
                  const Flexible(
                    child: Text(
                      'Saved Articles',
                      style: TextStyle(
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
                  stream: ref.read(databaseProvider)!.getFavoriteArticles(),
                  builder: (context, AsyncSnapshot<List<Article>> snapshot) {
                    if(snapshot.data == null) {
                      return const EmptyWidget(text: 'No articles saved...');
                    }
                    if(snapshot.data!.isEmpty) {
                      return const EmptyWidget(text: 'No articles saved...');
                    }
                    switch(snapshot.connectionState) {
                      case ConnectionState.active: {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            final article = snapshot.data![index];
                            return SavedArticleListTile(article: article);
                          })
                        );
                      }
                      case ConnectionState.waiting: {
                         if(snapshot.data == null) {
                            return const EmptyWidget(text: 'No articles saved...');
                          }
                          if(snapshot.data!.isEmpty) {
                            return const EmptyWidget(text: 'No articles saved...');
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
                          child: Text('No saved articles'),
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
