import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
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
                if(index == 0) return MainArticle(article: article);
                return Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      article.imageUrl != uploadImageError
                        ? ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: article.imageUrl!,
                            key: UniqueKey(),
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Colors.black12,),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.black12,
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          )
                        : const Text('No image found!'),
                      const SizedBox(width: 15,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.title,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  article.category,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 149, 149, 158),
                                    fontSize: 14.0
                                  ),
                                ),
                                Text(
                                  article.timestamp,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 149, 149, 158),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.0
                                  ),

                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          );
        } 
        return const EmptyWidget();
      },
    );
  }
}

