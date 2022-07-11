import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/displayed_user_article_tile.dart';
import 'package:news_app/widgets/empty_widget.dart';
import 'package:news_app/widgets/main_article.dart';

class DisplayArticles extends ConsumerWidget {
  const DisplayArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Article>>(
      stream: ref.read(databaseProvider)!.getArticles(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if(snapshot.connectionState == ConnectionState.active && snapshot.data != null) {
          if(snapshot.data!.isEmpty) return const EmptyWidget();
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Article article = snapshot.data![index];
                if(index == 0) { 
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text(
                        'Your daily read',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10,),
                      MainArticle(article: article),
                    ],
                  );
                }
                return DisplayedUserArticleListTile(article: article);
              }
            ),
          );
        } 
        return const EmptyWidget();
      },
    );
  }
}

